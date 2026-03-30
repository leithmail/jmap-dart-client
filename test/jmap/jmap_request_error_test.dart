import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_connection_exception.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_http_exception.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_parse_response_exception.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:test/test.dart';

import '../http_mocks.dart';

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
    });
  });
}
