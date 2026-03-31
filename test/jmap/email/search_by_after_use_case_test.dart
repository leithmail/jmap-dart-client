import 'package:jmap_dart_client/api/jmap_request.dart';
import 'package:jmap_dart_client/api/properties/properties.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/sort/comparator.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/entities/core/utc_date.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/entities/email/email_address.dart';
import 'package:jmap_dart_client/entities/email/email_comparator.dart';
import 'package:jmap_dart_client/entities/email/email_comparator_property.dart';
import 'package:jmap_dart_client/entities/email/email_filter_condition.dart';
import 'package:jmap_dart_client/methods/email/get_email_method.dart';
import 'package:jmap_dart_client/methods/email/get_email_response.dart';
import 'package:jmap_dart_client/methods/email/query_email_method.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  final expectMail = Email(
    id: EmailId(Id("04f27c50-e879-11ec-aae4-43ebf0340ebd")),
    preview: "AAAA",
    hasAttachment: false,
    subject: "AAAA",
    size: UnsignedInt(3328),
    from: {EmailAddress("Manh tuan Manh", "manh199672@gmail.com")},
    sentAt: UTCDate(DateTime.parse("2022-06-10T04:44:03Z")),
    receivedAt: UTCDate(DateTime.parse("2022-06-10T04:51:41Z")),
  );

  Future<List<Email>?> searchMailByCondition(Comparator comparator) async {
    final httpMockClient = HttpMockResponseClient(
      responseBody: {
        "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
        "methodResponses": [
          [
            "Email/query",
            {
              "accountId":
                  "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
              "queryState": "c4a08240",
              "canCalculateChanges": false,
              "ids": ["04f27c50-e879-11ec-aae4-43ebf0340ebd"],
              "position": 0,
              "limit": 256,
            },
            "c1",
          ],
          [
            "Email/get",
            {
              "accountId":
                  "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
              "notFound": [],
              "state": "94bbff20-e87c-11ec-aae4-43ebf0340ebd",
              "list": [
                {
                  "preview": "AAAA",
                  "hasAttachment": false,
                  "size": 3328,
                  "subject": "AAAA",
                  "from": [
                    {"name": "Manh tuan Manh", "email": "manh199672@gmail.com"},
                  ],
                  "sentAt": "2022-06-10T04:44:03Z",
                  "id": "04f27c50-e879-11ec-aae4-43ebf0340ebd",
                  "receivedAt": "2022-06-10T04:51:41Z",
                },
              ],
            },
            "c2",
          ],
        ],
      },
      expectedBody: {
        "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:mail"],
        "methodCalls": [
          [
            "Email/query",
            {
              "accountId":
                  "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
              "filter": {"after": "2022-05-12T06:12:00.000Z", "from": "manh"},
            },
            "c1",
          ],
          [
            "Email/get",
            {
              "accountId":
                  "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
              "#ids": {
                "resultOf": "c1",
                "name": "Email/query",
                "path": "/ids/*",
              },
              "properties": [
                "id",
                "subject",
                "size",
                "from",
                "receivedAt",
                "sentAt",
                "preview",
                "hasAttachment",
              ],
            },
            "c2",
          ],
        ],
      },
    );

    final processingInvocation = ProcessingInvocation();
    final jmapRequestBuilder = JmapRequestBuilder(processingInvocation);
    final accountId = AccountId(
      Id('0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb'),
    );

    final queryEmailMethod = QueryEmailMethod(accountId)
      ..addFilters(
        EmailFilterCondition(
          after: UTCDate(DateTime.parse('2022-05-12T06:12:00Z')),
          from: 'manh',
        ),
      );
    final queryEmailInvocation = jmapRequestBuilder.invocation(
      queryEmailMethod,
      methodCallId: MethodCallId('c1'),
    );

    final getEmailMethod = GetEmailMethod(accountId)
      ..addProperties(
        Properties({
          "id",
          "subject",
          "size",
          "from",
          "receivedAt",
          "sentAt",
          "preview",
          "hasAttachment",
        }),
      )
      ..addReferenceIds(
        processingInvocation.createResultReference(
          queryEmailInvocation.methodCallId,
          ReferencePath.idsPath,
        ),
      );
    final getEmailInvocation = jmapRequestBuilder.invocation(
      getEmailMethod,
      methodCallId: MethodCallId('c2'),
    );

    final result = await jmapRequestBuilder.build().execute(
      httpMockClient,
      MockEndpointHttpClient.endpointUri,
    );

    final resultList = result.parse<GetEmailResponse>(
      getEmailInvocation.methodCallId,
      GetEmailResponse.deserialize,
    );

    resultList.sortEmails(comparator);
    return resultList.list;
  }

  group('search email test', () {
    test('Search emails from someone in last 30 days', () async {
      final listEmailResponse = await searchMailByCondition(
        EmailComparator(EmailComparatorProperty.sentAt)..setIsAscending(false),
      );
      expect(listEmailResponse, containsAllInOrder([expectMail]));
    });
  });
}
