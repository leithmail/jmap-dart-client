import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:jmap_dart_client/api/endpoint_http_client.dart';

class MockEndpointHttpClient extends EndpointHttpClient {
  static final Uri endpointUri = Uri.parse('https://example.org/jmap');

  MockEndpointHttpClient(http.Client client, [String? endpointUri])
    : super(
        client,
        endpointUri != null
            ? Uri.parse(endpointUri)
            : MockEndpointHttpClient.endpointUri,
      );
}

class HttpMockException implements Exception {
  final String message;

  HttpMockException(this.message);

  @override
  String toString() => 'HttpMockException: $message';
}

/// A small `http` test client that validates an incoming request and returns
/// a predefined response.
///
/// This mock is intended for tests that want lightweight request assertions
/// without setting up a full HTTP server. By default it checks the incoming
/// request URL, method, body, and headers, then returns an [http.Response]
/// built from [responseBody], [statusCode], and [responseHeaders].
///
/// If any configured validation fails, the client throws
/// [HttpMockException]. This causes the test to fail with a message that
/// describes the mismatch, for example an unexpected URL, method, header, or
/// request body.
///
/// Supported body types for [responseBody] and [expectedBody] are:
/// - `null`, which is normalized to an empty body.
/// - `String`, returned as-is.
/// - `Map`, encoded as JSON.
/// - `List<int>`, decoded as UTF-8.
///
/// If [handler] is provided, it is called only after the built-in validation
/// succeeds. This lets tests customize the returned response while still
/// keeping the default assertions.
///
/// Basic response example:
/// ```dart
/// final client = HttpMockResponseClient(
///   responseBody: {'methodResponses': []},
/// );
/// ```
///
/// Validate a JSON request body and rely on the default RFC-style headers:
/// ```dart
/// final client = HttpMockResponseClient(
///   expectedBody: {
///     'using': ['urn:ietf:params:jmap:core'],
///   },
///   responseBody: {'methodResponses': []},
/// );
/// ```
///
/// Validate a custom method and URL:
/// ```dart
/// final client = HttpMockResponseClient(
///   expectedMethod: 'GET',
///   expectedUrl: 'https://example.org/session',
///   responseBody: {'apiUrl': 'https://example.org/jmap'},
/// );
/// ```
///
/// Provide a custom response handler after the default request validation:
/// ```dart
/// final client = HttpMockResponseClient(
///   responseBody: {'ignored': true},
///   handler: (request) => http.Response('accepted', 202),
/// );
/// ```
class HttpMockResponseClient extends MockClient {
  /// Creates a mock HTTP client with built-in request assertions and a default
  /// response.
  ///
  /// If [handler] is provided, it is used to generate the response after the
  /// built-in request validation succeeds. Otherwise, the response is built
  /// from [responseBody], [statusCode], and [responseHeaders].
  ///
  /// When [expectedHeaders] is omitted, the request is checked against the
  /// default RFC-style header expectation:
  /// `content-type: application/json`.
  ///
  /// When [responseHeaders] is omitted, the response is created with the
  /// default RFC-style header:
  /// `content-type: application/json`.
  ///
  /// If any built-in validation fails, a [HttpMockException] is thrown before
  /// a response is returned and [handler] is not called.
  HttpMockResponseClient({
    http.Response Function(http.Request request)? handler,
    Object? responseBody,
    int statusCode = 200,
    Object? expectedBody,
    Map<String, String>? expectedHeaders,
    Map<String, String>? responseHeaders,
    String? expectedMethod = 'POST',
    String? expectedUrl = 'https://example.org/jmap',
  }) : super((http.Request request) async {
         if (expectedUrl != null && request.url.toString() != expectedUrl) {
           throw HttpMockException(
             'Expected URI: $expectedUrl, but got: ${request.url}',
           );
         }
         if (expectedMethod != null && request.method != expectedMethod) {
           throw HttpMockException(
             'Expected method: $expectedMethod, but got: ${request.method}',
           );
         }
         if (expectedBody != null &&
             !_requestBodyMatches(request, expectedBody)) {
           final normalizedExpectedBody = _normalizeBody(expectedBody);
           throw HttpMockException(
             '\nExpected body: $normalizedExpectedBody\n' +
                 'Recieved body: ${request.body}',
           );
         }
         for (final entry
             in (expectedHeaders ?? _defaultRequestHeaders).entries) {
           if (request.headers[entry.key] != entry.value) {
             throw HttpMockException(
               'Expected header ${entry.key}: ${entry.value}, but got: ${request.headers[entry.key]}',
             );
           }
         }
         final normalizedResponseBody = _normalizeBody(responseBody);

         return handler != null
             ? handler(request)
             : http.Response(
                 normalizedResponseBody,
                 statusCode,
                 headers: responseHeaders ?? _defaultResponseHeaders,
               );
       });

  static const Map<String, String> _defaultRequestHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  static const Map<String, String> _defaultResponseHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  static bool _requestBodyMatches(http.Request request, Object? expectedBody) {
    if (expectedBody is Map) {
      return const DeepCollectionEquality().equals(
        jsonDecode(request.body),
        expectedBody,
      );
    }
    return request.body == _normalizeBody(expectedBody);
  }

  static String _normalizeBody(Object? body) {
    if (body == null) {
      return '';
    }

    if (body is String) {
      return body;
    }

    if (body is Map) {
      return jsonEncode(body);
    }

    if (body is List<int>) {
      return utf8.decode(body);
    }

    throw HttpMockException(
      'Unsupported body type: ${body.runtimeType}. Supported types are null, String, Map, and List<int>.',
    );
  }
}
