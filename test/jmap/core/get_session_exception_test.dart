import 'dart:io';

import 'package:jmap_dart_client/api/get_session.dart';
import 'package:jmap_dart_client/errors/exceptions.dart';
import 'package:jmap_dart_client/src/converters/capabilities_converter.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  group('GetSession.execute() exception behaviour', () {
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
        final httpEndpointClient = MockEndpointHttpClient(
          httpClient,
          'https://example.org/.well-known/jmap',
        );
        final getSession = GetSession(
          httpEndpointClient,
          CapabilitiesConverter(),
        );

        // act + assert
        expect(
          () => getSession.execute(),
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
        final httpEndpointClient = MockEndpointHttpClient(
          httpClient,
          'https://example.org/.well-known/jmap',
        );
        final getSession = GetSession(
          httpEndpointClient,
          CapabilitiesConverter(),
        );

        // act + assert
        await expectLater(
          () => getSession.execute(),
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
        final httpEndpointClient = MockEndpointHttpClient(
          httpClient,
          'https://example.org/.well-known/jmap',
        );
        final getSession = GetSession(
          httpEndpointClient,
          CapabilitiesConverter(),
        );

        // act + assert
        expect(
          () => getSession.execute(),
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
        final httpEndpointClient = MockEndpointHttpClient(
          httpClient,
          'https://example.org/.well-known/jmap',
        );
        final getSession = GetSession(
          httpEndpointClient,
          CapabilitiesConverter(),
        );

        // act + assert
        expect(
          () => getSession.execute(),
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
          final httpEndpointClient = MockEndpointHttpClient(
            httpClient,
            'https://example.org/.well-known/jmap',
          );
          final getSession = GetSession(
            httpEndpointClient,
            CapabilitiesConverter(),
          );

          // act + assert
          expect(
            () => getSession.execute(),
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
