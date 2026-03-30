import 'dart:io';

import 'package:jmap_dart_client/http/converter/capabilities_converter.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_connection_exception.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_http_exception.dart';
import 'package:jmap_dart_client/jmap/core/session/get_session.dart';
import 'package:test/test.dart';

import '../../../http_mocks.dart';

void main() {
  group('GetSession.execute() exception behaviour', () {
    group('401 response', () {
      test('throws JmapUnauthorizedException', () {
        // arrange
        final client = HttpMockResponseClient(
          expectedMethod: 'GET',
          expectedUrl: '/.well-known/jmap',
          expectedHeaders: {},
          statusCode: 401,
          responseBody: '',
        );
        final getSession = GetSession(client, CapabilitiesConverter());

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
        final client = HttpMockResponseClient(
          expectedMethod: 'GET',
          expectedUrl: '/.well-known/jmap',
          expectedHeaders: {},
          statusCode: 500,
          responseBody: '',
        );
        final getSession = GetSession(client, CapabilitiesConverter());

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
        final client = HttpMockResponseClient(
          expectedMethod: 'GET',
          expectedUrl: '/.well-known/jmap',
          expectedHeaders: {},
          handler: (_) => throw const SocketException('Connection refused'),
          responseBody: null,
        );
        final getSession = GetSession(client, CapabilitiesConverter());

        // act + assert
        expect(
          () => getSession.execute(),
          throwsA(isA<JmapConnectionException>()),
        );
      });
    });
  });
}
