# jmap_dart_client

[![CI](https://github.com/leithmail/jmap-dart-client/actions/workflows/ci.yml/badge.svg)](https://github.com/leithmail/jmap-dart-client/actions/workflows/ci.yml)
[![codecov](https://codecov.io/github/leithmail/jmap-dart-client/graph/badge.svg?token=SNE1L5DIIU)](https://codecov.io/github/leithmail/jmap-dart-client)

A Dart client library for [JMAP](https://jmap.io/), focused on building and executing method calls and parsing typed responses.

> [!IMPORTANT] 
> Early work in progress: APIs and docs may evolve.

- [jmap\_dart\_client](#jmap_dart_client)
  - [Project Direction](#project-direction)
  - [Installation Status](#installation-status)
  - [Public API](#public-api)
  - [Examples](#examples)
    - [Fetch JMAP Session](#fetch-jmap-session)
    - [Query Mailboxes](#query-mailboxes)
    - [Query Emails And Resolve IDs By Reference](#query-emails-and-resolve-ids-by-reference)
    - [Use A Custom `http.Client` (Example: Dio)](#use-a-custom-httpclient-example-dio)
  - [Error Handling](#error-handling)
  - [Contributing](#contributing)


## Project Direction

This repository started as a fork of [linagora/jmap-dart-client](https://github.com/linagora/jmap-dart-client).

The original project did important foundational work for JMAP support in Dart and deserves credit for that base. This fork is now maintained as a long-lived, independent line: it keeps compatibility where it makes sense, but it can intentionally diverge in API design, scope, and release cadence.

Main differences from upstream include:

- No unnecessary transport dependencies (for example, no Dio in the core package).
- HTTP built on the Dart `http.Client` interface, which keeps transport injectable and easy to swap.
- Substantially improved error handling and clearer exception boundaries.
- Focus on pure JMAP RFC implementation with no vendor-specific or Linagora-specific integrations.
- Pure Dart package with no Flutter dependency.

## Installation Status

This package is not published on pub.dev yet.

You can use it directly from this repository:

```yaml
dependencies:
  jmap_dart_client:
    git:
      url: https://github.com/leithmail/jmap-dart-client.git
```

## Public API

Use the main barrel import:

```dart
import 'package:jmap_dart_client/jmap_dart_client.dart';
```

The barrel exports the package's public, consumer-facing modules so you do not need to import deep internal paths for normal usage.

## Examples

### Fetch JMAP Session

```dart
import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/jmap_dart_client.dart';

final client = http.Client();
final session = await Session.fetch(client, Uri.parse('https://example.org/.well-known/jmap'));
```

### Query Mailboxes

```dart
import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/jmap_dart_client.dart';

Future<GetMailboxResponse> fetchMailboxes(
  Uri apiEndpoint,
  AccountId accountId,
) async {
  final client = http.Client();
  try {
    final requestBuilder = RequestBuilder();

    final getMailboxMethod = GetMailboxMethod(accountId)
      ..addProperties(Properties({'id', 'name', 'role', 'totalEmails'}));

    final getMailboxInvocation = requestBuilder.addInvocation(getMailboxMethod);

    final response = await requestBuilder.build().execute(client, apiEndpoint);
    return response.parse<GetMailboxResponse>(
      getMailboxInvocation.methodCallId,
      GetMailboxResponse.deserialize,
    );
  } finally {
    client.close();
  }
}
```

### Query Emails And Resolve IDs By Reference

```dart
import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/jmap_dart_client.dart';

Future<GetEmailResponse> fetchInboxEmails(
  Uri apiEndpoint,
  AccountId accountId,
  MailboxId inboxId,
) async {
  final client = http.Client();
  try {
    final requestBuilder = RequestBuilder();

    final queryEmailMethod = QueryEmailMethod(accountId)
      ..addPosition(0)
      ..addLimit(UnsignedInt(20))
      ..addSorts([
        EmailComparator(EmailComparatorProperty.sentAt)..setIsAscending(false),
      ])
      ..addFilters(EmailFilterCondition(inMailbox: inboxId));

    final queryInvocation = requestBuilder.addInvocation(queryEmailMethod);

    final getEmailMethod = GetEmailMethod(accountId)
      ..addProperties(
        Properties({'id', 'subject', 'from', 'sentAt', 'preview'}),
      )
      ..addReferenceIds(
          queryInvocation,
          ReferencePath.idsPath,
      );

    final getEmailInvocation = requestBuilder.addInvocation(getEmailMethod);

    final response = await requestBuilder.build().execute(client, apiEndpoint);
    return response.parse<GetEmailResponse>(
      getEmailInvocation.methodCallId,
      GetEmailResponse.deserialize,
    );
  } finally {
    client.close();
  }
}
```

### Use A Custom `http.Client` (Example: Dio)

You can inject any transport as long as it implements the `http.Client` interface.

```dart
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/jmap_dart_client.dart';

class DioHttpClient extends http.BaseClient {
  final Dio _dio;

  DioHttpClient(this._dio);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final streamedRequest = request as http.Request;

    final response = await _dio.request<List<int>>(
      streamedRequest.url.toString(),
      data: streamedRequest.bodyBytes,
      options: Options(
        method: streamedRequest.method,
        headers: streamedRequest.headers,
        responseType: ResponseType.bytes,
        validateStatus: (_) => true,
      ),
    );

    final bodyBytes = Uint8List.fromList(response.data ?? <int>[]);

    return http.StreamedResponse(
      Stream<List<int>>.fromIterable([bodyBytes]),
      response.statusCode ?? 500,
      headers: response.headers.map.map(
        (key, values) => MapEntry(key, values.join(',')),
      ),
      reasonPhrase: response.statusMessage,
      request: request,
    );
  }
}

Future<Session> loadSessionWithDio(Uri sessionEndpoint) async {
  final dioClient = DioHttpClient(Dio());

  try {
    final endpointClient = EndpointHttpClient(dioClient, sessionEndpoint);
    return await GetSessionBuilder(endpointClient).execute(
            httpMockClient,
            MockEndpointHttpClient.endpointUri,
          );
  } finally {
    dioClient.close();
  }
}
```

## Error Handling

The library exposes distinct exception types so callers can react precisely:

- `JmapException`: base exception type for all JMAP client exceptions.
- `JmapUnauthorizedException`: HTTP 401.
- `JmapHttpException`: any HTTP status >= 400.
- `JmapConnectionException`: transport/client failures.
- `JmapParseResponseException`: invalid or unexpected response payload.
- `JmapMethodErrorException`: typed JMAP method-level error from `ResponseObject.parse(...)`.

```dart
import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/jmap_dart_client.dart';

Future<void> runRequest(RequestObject request, http.Client client, Uri url) async {
  try {
    final response = await request.execute(client, url);
    // parse(...) may throw JmapMethodErrorException for method-level errors.
    response.parse(
      MethodCallId('c1'),
      GetMailboxResponse.deserialize,
    );
  } on JmapUnauthorizedException {
    // Ask user to re-authenticate.
  } on JmapHttpException catch (e) {
    // Server-side HTTP failure.
    print('HTTP error: ${e.statusCode}');
  } on JmapMethodErrorException catch (e) {
    // JMAP method returned an "error" response invocation.
    print('Method error: ${e.errorResponse}');
  } on JmapParseResponseException catch (e) {
    // Response could not be decoded or did not match expected shape.
    print('Parse error: $e');
  } on JmapConnectionException catch (e) {
    // Network or low-level client failure.
    print('Connection error: ${e.cause}');
  } on JmapException catch (e) {
    // Generic fallback for any JMAP client exception.
    print('JMAP error: $e');
  }
}
```

## Contributing

Contributions are welcome.

- Found a bug? Please open an issue.
- Want a feature? Open an issue and describe the use case.
- Want to contribute code? Great, PRs are welcome.
