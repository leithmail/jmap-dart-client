import 'package:jmap_dart_client/api/errors/error_method_response.dart';
import 'package:jmap_dart_client/api/errors/exceptions.dart';
import 'package:jmap_dart_client/api/method/argument/filter/filter.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request_builder.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/entities/email/email_filter_condition.dart';
import 'package:jmap_dart_client/entities/email/search_snippet.dart';
import 'package:jmap_dart_client/methods/email/query_email_method.dart';
import 'package:jmap_dart_client/methods/email/search_snippet_get_method.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

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

      final jmapRequestBuilder = RequestBuilder();

      final emailQueryMethod = QueryEmailMethod(accountId)..filter.set(filter);
      final emailQueryMethodInvocation = jmapRequestBuilder.addInvocation(
        emailQueryMethod,
      );

      final searchSnippetGetMethod = SearchSnippetGetMethod(accountId)
        ..filter.set(filter);
      searchSnippetGetMethod.referenceEmailIds.ref(
        emailQueryMethodInvocation.createResultReference(ReferencePath.idsPath),
      );
      final searchSnippetGetMethodInvocation = jmapRequestBuilder.addInvocation(
        searchSnippetGetMethod,
      );

      // act
      final result = await jmapRequestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final searchSnippetGetResponse = searchSnippetGetMethodInvocation
          .parseResponse(result);
      // assert
      expect(searchSnippetGetResponse.list, equals(foundSearchSnippets));
      expect(searchSnippetGetResponse.notFound, isEmpty);
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

      final jmapRequestBuilder = RequestBuilder();

      final emailQueryMethod = QueryEmailMethod(accountId)..filter.set(filter);
      final emailQueryMethodInvocation = jmapRequestBuilder.addInvocation(
        emailQueryMethod,
      );

      final searchSnippetGetMethod = SearchSnippetGetMethod(accountId)
        ..filter.set(filter);
      searchSnippetGetMethod.referenceEmailIds.ref(
        emailQueryMethodInvocation.createResultReference(ReferencePath.idsPath),
      );
      final methodInvocation = jmapRequestBuilder.addInvocation(
        searchSnippetGetMethod,
      );

      // act
      final result = await jmapRequestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final searchSnippetGetResponse = methodInvocation.parseResponse(result);
      // assert
      expect(searchSnippetGetResponse.list, isEmpty);
      expect(
        searchSnippetGetResponse.notFound,
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

      final jmapRequestBuilder = RequestBuilder();

      final emailQueryMethod = QueryEmailMethod(accountId)..filter.set(filter);
      final emailQueryMethodInvocation = jmapRequestBuilder.addInvocation(
        emailQueryMethod,
      );

      final searchSnippetGetMethod = SearchSnippetGetMethod(accountId)
        ..filter.set(filter);
      searchSnippetGetMethod.referenceEmailIds.ref(
        emailQueryMethodInvocation.createResultReference(ReferencePath.idsPath),
      );
      final methodInvocation = jmapRequestBuilder.addInvocation(
        searchSnippetGetMethod,
      );

      // act
      final result = await jmapRequestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      // assert
      expect(
        () => methodInvocation.parseResponse(result),
        throwsA(
          isA<JmapMethodErrorException>().having(
            (e) => e.errorResponse,
            'errorResponse',
            isA<UnknownMethodResponse>(),
          ),
        ),
      );
    });
  });
}
