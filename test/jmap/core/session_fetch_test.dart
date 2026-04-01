import 'dart:io';

import 'package:jmap_dart_client/entities/core/session.dart';
import 'package:jmap_dart_client/errors/exceptions.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  group('Session.fetch exception behaviour', () {
    group('401 response', () {
      test('throws JmapUnauthorizedException', () {
        // arrange
        final httpClient = HttpMockResponseClient(
          expectedMethod: 'GET',
          expectedUrl: 'https://example.org/.well-known/jmap',
          expectedHeaders: {},
          statusCode: 401,
          responseBody: '',
        );

        // act + assert
        expect(
          () => Session.fetch(
            httpClient,
            Uri.parse('https://example.org/.well-known/jmap'),
          ),
          throwsA(isA<JmapUnauthorizedException>()),
        );
      });
    });

    group('500 response', () {
      test('throws JmapHttpException with statusCode 500', () async {
        // arrange
        final httpClient = HttpMockResponseClient(
          expectedMethod: 'GET',
          expectedUrl: 'https://example.org/.well-known/jmap',
          expectedHeaders: {},
          statusCode: 500,
          responseBody: '',
        );

        // act + assert
        await expectLater(
          () => Session.fetch(
            httpClient,
            Uri.parse('https://example.org/.well-known/jmap'),
          ),
          throwsA(
            isA<JmapHttpException>().having(
              (e) => e.statusCode,
              'statusCode',
              equals(500),
            ),
          ),
        );
      });
    });

    group('transport failure', () {
      test('throws JmapConnectionException on SocketException', () {
        // arrange
        final httpClient = HttpMockResponseClient(
          expectedMethod: 'GET',
          expectedUrl: 'https://example.org/.well-known/jmap',
          expectedHeaders: {},
          handler: (_) => throw const SocketException('Connection refused'),
          responseBody: null,
        );

        // act + assert
        expect(
          () => Session.fetch(
            httpClient,
            Uri.parse('https://example.org/.well-known/jmap'),
          ),
          throwsA(isA<JmapConnectionException>()),
        );
      });

      test('throws JmapConnectionException on any http.Client exception', () {
        // arrange — simulate a custom exception from a user-injected http.Client
        final httpClient = HttpMockResponseClient(
          expectedMethod: 'GET',
          expectedUrl: 'https://example.org/.well-known/jmap',
          expectedHeaders: {},
          handler: (_) => throw Exception('custom transport error'),
          responseBody: null,
        );
        // act + assert
        expect(
          () => Session.fetch(
            httpClient,
            Uri.parse('https://example.org/.well-known/jmap'),
          ),
          throwsA(isA<JmapConnectionException>()),
        );
      });
    });

    group('malformed response body', () {
      test(
        'throws JmapParseResponseException (not JmapConnectionException) when JSON shape is invalid',
        () {
          // arrange
          final httpClient = HttpMockResponseClient(
            expectedMethod: 'GET',
            expectedUrl: 'https://example.org/.well-known/jmap',
            expectedHeaders: {},
            statusCode: 200,
            responseBody: {'invalid': true},
          );

          // act + assert
          expect(
            () => Session.fetch(
              httpClient,
              Uri.parse('https://example.org/.well-known/jmap'),
            ),
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
