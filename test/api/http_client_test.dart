import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/api/http_client.dart';
import 'package:test/test.dart';

import '../helpers/http_mocks.dart';

void main() {
  group('HttpClient', () {
    test('adds configured headers and preserves the request body', () async {
      final innerClient = HttpMockResponseClient(
        expectedMethod: 'POST',
        expectedUrl: 'https://example.org/jmap',
        expectedHeaders: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer token',
          'x-trace-id': 'trace-123',
        },
        expectedBody: {'hello': 'world'},
        statusCode: 202,
        responseBody: {'ok': true},
      );
      final client = HttpClient(
        innerClient,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer token',
          'x-trace-id': 'trace-123',
        },
      );

      final request = http.Request('POST', HttpMockResponseClient.defaultUri)
        ..headers[HttpHeaders.contentTypeHeader] = 'application/json'
        ..body = jsonEncode({'hello': 'world'});

      final streamedResponse = await client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      expect(response.statusCode, equals(202));
      expect(response.body, equals('{"ok":true}'));
    });

    test('request headers override client-level headers', () async {
      final innerClient = HttpMockResponseClient(
        expectedMethod: 'POST',
        expectedHeaders: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer request-token',
          'x-client-id': 'client-123',
        },
        expectedBody: {'id': 1},
        responseBody: {'merged': true},
      );
      final client = HttpClient(
        innerClient,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer default-token',
          'x-client-id': 'client-123',
        },
      );

      final response = await client.post(
        HttpMockResponseClient.defaultUri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer request-token',
        },
        body: jsonEncode({'id': 1}),
      );

      expect(response.statusCode, equals(200));
      expect(response.body, equals('{"merged":true}'));
    });

    test(
      'forwards request headers unchanged when no client headers are set',
      () async {
        final innerClient = HttpMockResponseClient(
          expectedMethod: 'POST',
          expectedHeaders: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'x-request-id': 'req-42',
          },
          expectedBody: {'value': 'test'},
          responseBody: {'accepted': true},
        );
        final client = HttpClient(innerClient);

        final response = await client.post(
          HttpMockResponseClient.defaultUri,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'x-request-id': 'req-42',
          },
          body: jsonEncode({'value': 'test'}),
        );

        expect(response.statusCode, equals(200));
        expect(response.body, equals('{"accepted":true}'));
      },
    );
  });
}
