import 'package:jmap_dart_client/api/properties/properties.dart';
import 'package:jmap_dart_client/api/request_builder.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/utc_date.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/entities/email/email_address.dart';
import 'package:jmap_dart_client/methods/email/parse_email_method.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  group('Test to json parse email method', () {
    final expectMail1 = Email(
      id: EmailId(Id("382312d0-fa5c-11eb-b647-2fef1ee78d9e")),
      preview: "Preview email 1",
      hasAttachment: false,
      subject: "Subject email 1",
      from: {EmailAddress("user1", "user1@examaple.com")},
      sentAt: UTCDate(DateTime.parse("2021-08-11T04:25:34Z")),
      receivedAt: UTCDate(DateTime.parse("2021-08-11T04:25:55Z")),
    );

    final expectMail2 = Email(
      id: EmailId(Id("bc8a5320-fa58-11eb-b647-2fef1ee78d9e")),
      preview: "Preview email 2",
      hasAttachment: false,
      subject: "Subject email 2",
      from: {EmailAddress(null, "user2@examaple.com")},
      sentAt: UTCDate(DateTime.parse("2021-08-10T09:45:01Z")),
      receivedAt: UTCDate(DateTime.parse("2021-08-11T04:00:59Z")),
    );

    final expectMail3 = Email(
      id: EmailId(Id("182312d0-fa5c-11eb-b647-2fef1ee78d9e")),
      preview: "Preview email 3",
      subject: "Subject email 3",
    );

    final accountId = AccountId(
      Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6'),
    );
    final blobId1 = Id('0f9f65ab-dc7b-4146-850f-6e4881093965');
    final blobId2 = Id('1f9f65ab-dc7b-4146-850f-6e4881093965');
    final blobId3 = Id('2f9f65ab-dc7b-4146-850f-6e4881093965');
    final blobIdNotFound = Id('3f9f65ab-dc7b-4146-850f-6e4881093965');
    final blobIdNotParsable = Id('4f9f65ab-dc7b-4146-850f-6e4881093965');

    test('ParseEmailMethod parse should succeed', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "Email/parse",
              {
                "accountId": accountId.id.value,
                "parsed": {
                  blobId1.value: {
                    "preview": "Preview email 1",
                    "hasAttachment": false,
                    "subject": "Subject email 1",
                    "from": [
                      {"name": "user1", "email": "user1@example.com"},
                    ],
                    "sentAt": "2021-08-11T04:25:34Z",
                    "id": "382312d0-fa5c-11eb-b647-2fef1ee78d9e",
                    "receivedAt": "2021-08-11T04:25:55Z",
                  },
                },
              },
              "c0",
            ],
          ],
        },
        expectedBody: {
          "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:mail"],
          "methodCalls": [
            [
              "Email/parse",
              {
                "accountId": accountId.id.value,
                "blobIds": [blobId1.value],
              },
              "c0",
            ],
          ],
        },
      );

      final parseEmailMethod = ParseEmailMethod(accountId, {blobId1});

      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(parseEmailMethod);
      final response = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final emailParsed = invocation.parseResponse(response);
      expect(emailParsed.parsed![blobId1]!.id, equals(expectMail1.id));
    });

    test('ParseEmailMethod parse should support several blobIds', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "Email/parse",
              {
                "accountId": accountId.id.value,
                "parsed": {
                  blobId1.value: {
                    "preview": "Preview email 1",
                    "hasAttachment": false,
                    "subject": "Subject email 1",
                    "from": [
                      {"name": "user1", "email": "user1@example.com"},
                    ],
                    "sentAt": "2021-08-11T04:25:34Z",
                    "id": "382312d0-fa5c-11eb-b647-2fef1ee78d9e",
                    "receivedAt": "2021-08-11T04:25:55Z",
                  },
                  blobId2.value: {
                    "preview": "Preview email 2",
                    "hasAttachment": false,
                    "subject": "Subject email 2",
                    "from": [
                      {"name": "user2", "email": "user2@example.com"},
                    ],
                    "sentAt": "2021-08-10T09:45:01Z",
                    "id": "bc8a5320-fa58-11eb-b647-2fef1ee78d9e",
                    "receivedAt": "2021-08-11T04:00:59Z",
                  },
                },
              },
              "c0",
            ],
          ],
        },
        expectedBody: {
          "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:mail"],
          "methodCalls": [
            [
              "Email/parse",
              {
                "accountId": accountId.id.value,
                "blobIds": [blobId1.value, blobId2.value],
              },
              "c0",
            ],
          ],
        },
      );

      final parseEmailMethod = ParseEmailMethod(accountId, {blobId1, blobId2});

      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(parseEmailMethod);
      final response = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final emailParsed = invocation.parseResponse(response);
      expect(emailParsed.parsed!.length, 2);
      expect(
        emailParsed.parsed!.values.map((email) => email.id),
        containsAll([expectMail1.id, expectMail2.id]),
      );
      expect(emailParsed.parsed![blobId1]!.id, equals(expectMail1.id));
      expect(emailParsed.parsed![blobId2]!.id, equals(expectMail2.id));
    });

    test(
      'ParseEmailMethod parse should return not found result when blobId does not exist',
      () async {
        final httpMockClient = HttpMockResponseClient(
          responseBody: {
            "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
            "methodResponses": [
              [
                "Email/parse",
                {
                  "accountId": accountId.id.value,
                  "notFound": [blobIdNotFound.value],
                },
                "c0",
              ],
            ],
          },
          expectedBody: {
            "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:mail"],
            "methodCalls": [
              [
                "Email/parse",
                {
                  "accountId": accountId.id.value,
                  "blobIds": [blobIdNotFound.value],
                },
                "c0",
              ],
            ],
          },
        );

        final parseEmailMethod = ParseEmailMethod(accountId, {blobIdNotFound});

        final requestBuilder = RequestBuilder();
        final invocation = requestBuilder.addInvocation(parseEmailMethod);
        final response = await requestBuilder.build().execute(
          httpMockClient,
          HttpMockResponseClient.defaultUri,
        );

        final emailParsed = invocation.parseResponse(response);
        expect(emailParsed.notFound, contains(blobIdNotFound));
      },
    );

    test('ParseEmailMethod parse should return not parsable', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "Email/parse",
              {
                "accountId": accountId.id.value,
                "notParsable": [blobIdNotParsable.value],
              },
              "c0",
            ],
          ],
        },
        expectedBody: {
          "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:mail"],
          "methodCalls": [
            [
              "Email/parse",
              {
                "accountId": accountId.id.value,
                "blobIds": [blobIdNotParsable.value],
              },
              "c0",
            ],
          ],
        },
      );

      final parseEmailMethod = ParseEmailMethod(accountId, {blobIdNotParsable});

      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(parseEmailMethod);
      final response = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final emailParsed = invocation.parseResponse(response);

      expect(emailParsed.notParsable, contains(blobIdNotParsable));
    });

    test('ParseEmailMethod parse with properties should succeed', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "Email/parse",
              {
                "accountId": accountId.id.value,
                "parsed": {
                  blobId3.value: {
                    "id": "182312d0-fa5c-11eb-b647-2fef1ee78d9e",
                    "preview": "Preview email 3",
                    "subject": "Subject email 3",
                  },
                },
              },
              "c0",
            ],
          ],
        },
        expectedBody: {
          "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:mail"],
          "methodCalls": [
            [
              "Email/parse",
              {
                "accountId": accountId.id.value,
                "blobIds": [blobId3.value],
                "properties": ["id", "preview", "subject"],
              },
              "c0",
            ],
          ],
        },
      );

      final parseEmailMethod = ParseEmailMethod(accountId, {blobId3})
        ..addProperties(Properties({"id", "preview", "subject"}));

      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(parseEmailMethod);
      final response = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final emailParsed = invocation.parseResponse(response);
      expect(emailParsed.parsed![blobId3]!.id, equals(expectMail3.id));
    });
  });
}
