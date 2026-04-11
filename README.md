# jmap_dart_client

[![CI](https://github.com/leithmail/jmap-dart-client/actions/workflows/ci.yml/badge.svg)](https://github.com/leithmail/jmap-dart-client/actions/workflows/ci.yml)
[![codecov](https://codecov.io/github/leithmail/jmap-dart-client/graph/badge.svg?token=SNE1L5DIIU)](https://codecov.io/github/leithmail/jmap-dart-client)

A Dart client library for [JMAP](https://jmap.io/), focused on building requests, executing method calls, and parsing typed responses through a simpler, more consistent API.

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

The original project did important foundational work for JMAP support in Dart and deserves credit for that base. This fork is now maintained as a long-lived, independent line with its own API design, scope, and release cadence.

Main differences from upstream include:

- A more opinionated, simplified public API.
- A lightweight, transport-agnostic core built around Dart's `http.Client`.
- A stronger focus on standards-based JMAP behavior and clear error handling.
- No Flutter dependency and no vendor-specific integrations in the core package.

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

Use the main barrel import and alias it in your application code:

```dart
import 'package:jmap_dart_client/jmap_dart_client.dart' as jmap;
```

The barrel exports the supported, consumer-facing API. Anything under `lib/src/` is internal and should be treated as private implementation detail.

## Examples

### Fetch JMAP Session

```dart
import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/jmap_dart_client.dart' as jmap;

Future<jmap.Session> fetchSession(Uri sessionUrl) async {
  final client = http.Client();

  try {
    return await jmap.fetchSession(client, sessionUrl);
  } finally {
    client.close();
  }
}
```

### Query Mailboxes

```dart
import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/jmap_dart_client.dart' as jmap;

Future<jmap.GetMailboxResponse> fetchMailboxes(
  Uri apiEndpoint,
  jmap.AccountId accountId,
) async {
  final client = http.Client();

  try {
    final requestBuilder = jmap.RequestBuilder();

    final getMailboxMethod = jmap.GetMailboxMethod(accountId)
      ..setProperties(
        jmap.Properties({'id', 'name', 'role', 'totalEmails'}),
      );

    final getMailboxInvocation = requestBuilder.addInvocation(getMailboxMethod);

    final response = await requestBuilder.build().execute(client, apiEndpoint);

    return getMailboxInvocation.parseResponse(response);
  } finally {
    client.close();
  }
}
```

### Query Emails And Resolve IDs By Reference

```dart
import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/jmap_dart_client.dart' as jmap;

Future<jmap.GetEmailResponse> fetchInboxEmails(
  Uri apiEndpoint,
  jmap.AccountId accountId,
  jmap.MailboxId inboxId,
) async {
  final client = http.Client();

  try {
    final requestBuilder = jmap.RequestBuilder();

    final queryEmailMethod = jmap.QueryEmailMethod(accountId)
      ..addPosition(0)
      ..addLimit(20)
      ..addSorts([
        jmap.EmailComparator(jmap.EmailComparatorProperty.sentAt)
          ..setIsAscending(false),
      ])
      ..addFilters(jmap.EmailFilterCondition(inMailbox: inboxId));

    final queryInvocation = requestBuilder.addInvocation(queryEmailMethod);

    final getEmailMethod = jmap.GetEmailMethod(accountId)
      ..setProperties(
        jmap.Properties({'id', 'subject', 'from', 'sentAt', 'preview'}),
      )
      ..setReferenceIds(queryInvocation, jmap.ReferencePath.idsPath);

    final getEmailInvocation = requestBuilder.addInvocation(getEmailMethod);

    final response = await requestBuilder.build().execute(client, apiEndpoint);

    return getEmailInvocation.parseResponse(response);
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
import 'package:jmap_dart_client/jmap_dart_client.dart' as jmap;

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

Future<jmap.Session> loadSessionWithDio(Uri sessionEndpoint) async {
  final dioClient = DioHttpClient(Dio());

  try {
    return await jmap.fetchSession(dioClient, sessionEndpoint);
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
- `JmapMethodErrorException`: typed JMAP method-level error from `RequestInvocation.parseResponse(...)`.

```dart
import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/jmap_dart_client.dart' as jmap;

Future<void> runRequest(
  http.Client client,
  Uri url,
  jmap.AccountId accountId,
) async {
  final requestBuilder = jmap.RequestBuilder();
  final getMailboxInvocation = requestBuilder.addInvocation(
    jmap.GetMailboxMethod(accountId),
  );
  final request = requestBuilder.build();

  try {
    final response = await request.execute(client, url);
    getMailboxInvocation.parseResponse(response);
  } on jmap.JmapUnauthorizedException {
    // Ask user to re-authenticate.
  } on jmap.JmapHttpException catch (e) {
    // Server-side HTTP failure.
    print('HTTP error: ${e.statusCode}');
  } on jmap.JmapMethodErrorException catch (e) {
    // JMAP method returned an "error" response invocation.
    print('Method error: ${e.errorResponse}');
  } on jmap.JmapParseResponseException catch (e) {
    // Response could not be decoded or did not match expected shape.
    print('Parse error: $e');
  } on jmap.JmapConnectionException catch (e) {
    // Network or low-level client failure.
    print('Connection error: ${e.cause}');
  } on jmap.JmapException catch (e) {
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
