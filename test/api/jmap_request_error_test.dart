import 'dart:io';

import 'package:jmap_dart_client/api/request/request_object.dart';
import 'package:jmap_dart_client/errors/exceptions.dart';
import 'package:test/test.dart';

import '../helpers/http_mocks.dart';

void main() {
  group('RequestObject.execute() exception behaviour', () {
    RequestObject buildRequest() {
      return RequestObject({}, []);
    }

    group('401 response', () {
      test('throws JmapUnauthorizedException', () {
        // arrange
        final client = HttpMockResponseClient(
          statusCode: 401,
          responseBody: '',
        );
        final request = buildRequest();

        // act + assert
        expect(
          () => request.execute(client, HttpMockResponseClient.defaultUri),
          throwsA(isA<JmapUnauthorizedException>()),
        );
      });
    });

    group('503 response', () {
      test('throws JmapHttpException with statusCode 503', () async {
        // arrange
        final client = HttpMockResponseClient(
          statusCode: 503,
          responseBody: '',
        );
        final request = buildRequest();

        // act + assert
        await expectLater(
          () => request.execute(client, HttpMockResponseClient.defaultUri),
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
        final client = HttpMockResponseClient(
          handler: (_) => throw const SocketException('Connection refused'),
          responseBody: null,
        );
        final request = buildRequest();

        // act + assert
        expect(
          () => request.execute(client, HttpMockResponseClient.defaultUri),
          throwsA(isA<JmapConnectionException>()),
        );
      });

      test('throws JmapConnectionException on any http.Client exception', () {
        // arrange — simulate a custom exception from a user-injected http.Client
        final client = HttpMockResponseClient(
          handler: (_) => throw Exception('custom transport error'),
          responseBody: null,
        );
        final request = buildRequest();

        // act + assert
        expect(
          () => request.execute(client, HttpMockResponseClient.defaultUri),
          throwsA(isA<JmapConnectionException>()),
        );
      });
    });

    group('malformed response body', () {
      test('throws JmapParseResponseException on non-JSON body', () {
        // arrange
        final client = HttpMockResponseClient(
          statusCode: 200,
          responseBody: 'not valid json {{{{',
        );
        final request = buildRequest();

        // act + assert
        expect(
          () => request.execute(client, HttpMockResponseClient.defaultUri),
          throwsA(isA<JmapParseResponseException>()),
        );
      });

      test(
        'throws JmapParseResponseException (not JmapConnectionException) when JSON shape is invalid',
        () {
          // arrange
          final client = HttpMockResponseClient(
            statusCode: 200,
            responseBody: {'invalid': true},
          );
          final request = buildRequest();

          // act + assert
          expect(
            () => request.execute(client, HttpMockResponseClient.defaultUri),
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
