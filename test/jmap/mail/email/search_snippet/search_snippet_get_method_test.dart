import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/error/error_method_response.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_method_error_exception.dart';
import 'package:jmap_dart_client/jmap/core/filter/filter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/request/reference_path.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_filter_condition.dart';
import 'package:jmap_dart_client/jmap/mail/email/query/query_email_method.dart';
import 'package:jmap_dart_client/jmap/mail/email/search_snippet/search_snippet.dart';
import 'package:jmap_dart_client/jmap/mail/email/search_snippet/search_snippet_get_method.dart';
import 'package:jmap_dart_client/jmap/mail/email/search_snippet/search_snippet_get_response.dart';
import 'package:test/test.dart';

import '../../../../http_mocks.dart';

void main() {
  final sessionState = State('some-session-state');
  final state = State('some-state');
  final accountId = AccountId(Id('some-account-id'));

  Map<String, dynamic> generateResponse({
    required List<SearchSnippet> foundSearchSnippets,
    required List<EmailId> notFoundEmailIds,
  }) => {
    "sessionState": sessionState.value,
    "methodResponses": [
      [
        "Email/query",
        {
          "accountId": accountId.id.value,
          "ids":
              foundSearchSnippets
                  .map((searchSnippet) => searchSnippet.emailId.id.value)
                  .toList()
                ..addAll(notFoundEmailIds.map((emailId) => emailId.id.value)),
        },
        "c0",
      ],
      [
        "SearchSnippet/get",
        {
          "accountId": accountId.id.value,
          "notFound": notFoundEmailIds
              .map((emailId) => emailId.id.value)
              .toList(),
          "state": state.value,
          "list": foundSearchSnippets
              .map((searchSnippet) => searchSnippet.toJson())
              .toList(),
        },
        "c1",
      ],
    ],
  };

  Map<String, dynamic> generateRequest({
    required List<SearchSnippet> foundSearchSnippets,
    required List<EmailId> notFoundEmailIds,
    required Filter filter,
  }) => {
    "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:mail"],
    "methodCalls": [
      [
        "Email/query",
        {"accountId": accountId.id.value, "filter": filter.toJson()},
        "c0",
      ],
      [
        "SearchSnippet/get",
        {
          "accountId": accountId.id.value,
          "filter": filter.toJson(),
          "#emailIds": {
            "resultOf": "c0",
            "name": "Email/query",
            "path": "/ids/*",
          },
        },
        "c1",
      ],
    ],
  };

  group('search snippet get method test:', () {
    test('should return search snippet if email exists', () async {
      // arrange
      final foundSearchSnippets = [
        SearchSnippet(
          emailId: EmailId(Id('some-email-id')),
          subject: "some-subject",
          preview: "some-preview",
        ),
      ];
      final filter = EmailFilterCondition(text: 'some-text');
      final httpMockClient = HttpMockResponseClient(
        responseBody: generateResponse(
          foundSearchSnippets: foundSearchSnippets,
          notFoundEmailIds: [],
        ),
        expectedBody: generateRequest(
          foundSearchSnippets: foundSearchSnippets,
          notFoundEmailIds: [],
          filter: filter,
        ),
      );

      final httpClient = MockEndpointHttpClient(httpMockClient);
      final processingInvocation = ProcessingInvocation();
      final jmapRequestBuilder = JmapRequestBuilder(
        httpClient,
        processingInvocation,
      );

      final emailQueryMethod = QueryEmailMethod(accountId)..filter = filter;
      final emailQueryMethodInvocation = jmapRequestBuilder.invocation(
        emailQueryMethod,
      );

      final searchSnippetGetMethod = SearchSnippetGetMethod(accountId)
        ..filter = filter;
      searchSnippetGetMethod.addReferenceEmailIds(
        processingInvocation.createResultReference(
          emailQueryMethodInvocation.methodCallId,
          ReferencePath.idsPath,
        ),
      );
      final searchSnippetGetMethodInvocation = jmapRequestBuilder.invocation(
        searchSnippetGetMethod,
      );

      // act
      final result =
          await (jmapRequestBuilder
                ..usings(searchSnippetGetMethod.requiredCapabilities))
              .build()
              .execute();

      final searchSnippetGetResponse = result.parse<SearchSnippetGetResponse>(
        searchSnippetGetMethodInvocation.methodCallId,
        SearchSnippetGetResponse.fromJson,
      );

      // assert
      expect(searchSnippetGetResponse?.list, equals(foundSearchSnippets));
      expect(searchSnippetGetResponse?.notFound, isEmpty);
    });

    test('should return null if email not found', () async {
      // arrange
      final notFoundEmailIds = [EmailId(Id('some-email-id'))];
      final filter = EmailFilterCondition(text: 'some-text');
      final httpMockClient = HttpMockResponseClient(
        responseBody: generateResponse(
          foundSearchSnippets: [],
          notFoundEmailIds: notFoundEmailIds,
        ),
        expectedBody: generateRequest(
          foundSearchSnippets: [],
          notFoundEmailIds: notFoundEmailIds,
          filter: filter,
        ),
      );

      final httpClient = MockEndpointHttpClient(httpMockClient);
      final processingInvocation = ProcessingInvocation();
      final jmapRequestBuilder = JmapRequestBuilder(
        httpClient,
        processingInvocation,
      );

      final emailQueryMethod = QueryEmailMethod(accountId)..filter = filter;
      final emailQueryMethodInvocation = jmapRequestBuilder.invocation(
        emailQueryMethod,
      );

      final searchSnippetGetMethod = SearchSnippetGetMethod(accountId)
        ..filter = filter;
      searchSnippetGetMethod.addReferenceEmailIds(
        processingInvocation.createResultReference(
          emailQueryMethodInvocation.methodCallId,
          ReferencePath.idsPath,
        ),
      );
      final methodInvocation = jmapRequestBuilder.invocation(
        searchSnippetGetMethod,
      );

      // act
      final result =
          await (jmapRequestBuilder
                ..usings(searchSnippetGetMethod.requiredCapabilities))
              .build()
              .execute();

      final searchSnippetGetResponse = result.parse<SearchSnippetGetResponse>(
        methodInvocation.methodCallId,
        SearchSnippetGetResponse.fromJson,
      );

      // assert
      expect(searchSnippetGetResponse?.list, isEmpty);
      expect(
        searchSnippetGetResponse?.notFound,
        equals(notFoundEmailIds.map((emailId) => emailId.id)),
      );
    });

    test('should return error if server returns error', () async {
      // arrange
      final notFoundEmailIds = [EmailId(Id('some-email-id'))];
      final filter = EmailFilterCondition(text: 'some-text');
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "Email/query",
              {
                "accountId": accountId.id.value,
                "ids": notFoundEmailIds
                    .map((emailId) => emailId.id.value)
                    .toList(),
              },
              "c0",
            ],
            [
              "error",
              {"type": "unknownMethod"},
              "c1",
            ],
          ],
        },
        expectedBody: generateRequest(
          foundSearchSnippets: [],
          notFoundEmailIds: notFoundEmailIds,
          filter: filter,
        ),
      );

      final httpClient = MockEndpointHttpClient(httpMockClient);
      final processingInvocation = ProcessingInvocation();
      final jmapRequestBuilder = JmapRequestBuilder(
        httpClient,
        processingInvocation,
      );

      final emailQueryMethod = QueryEmailMethod(accountId)..filter = filter;
      final emailQueryMethodInvocation = jmapRequestBuilder.invocation(
        emailQueryMethod,
      );

      final searchSnippetGetMethod = SearchSnippetGetMethod(accountId)
        ..filter = filter;
      searchSnippetGetMethod.addReferenceEmailIds(
        processingInvocation.createResultReference(
          emailQueryMethodInvocation.methodCallId,
          ReferencePath.idsPath,
        ),
      );
      final methodInvocation = jmapRequestBuilder.invocation(
        searchSnippetGetMethod,
      );

      // act
      final result =
          await (jmapRequestBuilder
                ..usings(searchSnippetGetMethod.requiredCapabilities))
              .build()
              .execute();

      // assert
      expect(
        () => result.parse<SearchSnippetGetResponse>(
          methodInvocation.methodCallId,
          SearchSnippetGetResponse.fromJson,
        ),
        throwsA(JmapMethodErrorException(UnknownMethodResponse())),
      );
    });
  });
}
