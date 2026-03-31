import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:jmap_dart_client/api/jmap_request.dart';
import 'package:jmap_dart_client/errors/jmap_connection_exception.dart';
import 'package:jmap_dart_client/errors/jmap_http_exception.dart';
import 'package:jmap_dart_client/errors/jmap_parse_response_exception.dart';
import 'package:test/test.dart';

import '../helpers/http_mocks.dart';

void main() {
  group('JmapRequest.execute() exception behaviour', () {
    JmapRequest buildRequest(HttpMockResponseClient httpMock) {
      final endpointClient = MockEndpointHttpClient(httpMock);
      return JmapRequest(endpointClient, BuiltSet(), BuiltMap());
    }

    group('401 response', () {
      test('throws JmapUnauthorizedException', () {
        // arrange
        final request = buildRequest(
          HttpMockResponseClient(statusCode: 401, responseBody: ''),
        );

        // act + assert
        expect(
          () => request.execute(),
          throwsA(isA<JmapUnauthorizedException>()),
        );
      });
    });

    group('503 response', () {
      test('throws JmapHttpException with statusCode 503', () async {
        // arrange
        final request = buildRequest(
          HttpMockResponseClient(statusCode: 503, responseBody: ''),
        );

        // act + assert
        await expectLater(
          () => request.execute(),
          throwsA(
            isA<JmapHttpException>().having(
              (e) => e.statusCode,
              'statusCode',
              equals(503),
            ),
          ),
        );
      });
    });

    group('transport failure', () {
      test('throws JmapConnectionException on SocketException', () {
        // arrange
        final request = buildRequest(
          HttpMockResponseClient(
            handler: (_) => throw const SocketException('Connection refused'),
            responseBody: null,
          ),
        );

        // act + assert
        expect(
          () => request.execute(),
          throwsA(isA<JmapConnectionException>()),
        );
      });

      test('throws JmapConnectionException on any http.Client exception', () {
        // arrange — simulate a custom exception from a user-injected http.Client
        final request = buildRequest(
          HttpMockResponseClient(
            handler: (_) => throw Exception('custom transport error'),
            responseBody: null,
          ),
        );

        // act + assert
        expect(
          () => request.execute(),
          throwsA(isA<JmapConnectionException>()),
        );
      });
    });

    group('malformed response body', () {
      test('throws JmapParseResponseException on non-JSON body', () {
        // arrange
        final request = buildRequest(
          HttpMockResponseClient(
            statusCode: 200,
            responseBody: 'not valid json {{{{',
          ),
        );

        // act + assert
        expect(
          () => request.execute(),
          throwsA(isA<JmapParseResponseException>()),
        );
      });

      test(
        'throws JmapParseResponseException (not JmapConnectionException) when JSON shape is invalid',
        () {
          // arrange
          final request = buildRequest(
            HttpMockResponseClient(
              statusCode: 200,
              responseBody: {'invalid': true},
            ),
          );

          // act + assert
          expect(
            () => request.execute(),
            throwsA(
              isA<JmapParseResponseException>().having(
                (e) => e,
                'not connection exception',
                isNot(isA<JmapConnectionException>()),
              ),
            ),
          );
        },
      );
    });
  });
}
