import 'package:jmap_dart_client/api/properties/properties.dart';
import 'package:jmap_dart_client/api/request_builder.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/entities/core/utc_date.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/entities/email/email_address.dart';
import 'package:jmap_dart_client/entities/email/individual_header_identifier.dart';
import 'package:jmap_dart_client/methods/email/get_email_method.dart';
import 'package:jmap_dart_client/methods/email/get_email_response.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  group('[Email/get] test', () {
    final expectMail = Email(
      id: EmailId(Id("54fa3000-2595-11ec-a759-2fef1ee78d9e")),
      preview:
          "This event is about to begin A - show datetime1 TimeTuesday 15 September 2020 07:03 - 07:33 Europe/Paris (See in Calendar)Location1 thai ha1 (See in Map)Attendees - User A <usera@qa.open-paas.org> (Organizer) - Thanh Loan LE <tlle@linagora.com> - User C <u",
      hasAttachment: false,
      size: UnsignedInt(24857),
      subject: "Notification: A - show datetime1",
      keywords: {},
      from: {EmailAddress(null, "noreply@qa.open-paas.org")},
      to: {EmailAddress(null, "userb@qa.open-paas.org")},
      sentAt: UTCDate(DateTime.parse("2021-10-05T04:33:01Z")),
      receivedAt: UTCDate(DateTime.parse("2021-10-05T04:33:04Z")),
      headerCalendarEvent: {
        IndividualHeaderIdentifier.headerCalendarEvent:
            "64fa3000-2595-11ec-a759-2fef1ee78d9e",
      },
    );

    test(
      'get email method and response parsing with header Calendar Event',
      () async {
        final httpMockClient = HttpMockResponseClient(
          responseBody: {
            "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
            "methodResponses": [
              [
                "Email/get",
                {
                  "accountId":
                      "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                  "notFound": [],
                  "state": "561dc870-2595-11ec-a759-2fef1ee78d9e",
                  "list": [
                    {
                      "preview":
                          "This event is about to begin A - show datetime1 TimeTuesday 15 September 2020 07:03 - 07:33 Europe/Paris (See in Calendar)Location1 thai ha1 (See in Map)Attendees - User A <usera@qa.open-paas.org> (Organizer) - Thanh Loan LE <tlle@linagora.com> - User C <u",
                      "hasAttachment": false,
                      "size": 24857,
                      "keywords": {},
                      "subject": "Notification: A - show datetime1",
                      "from": [
                        {"email": "noreply@qa.open-paas.org"},
                      ],
                      "sentAt": "2021-10-05T04:33:01Z",
                      "id": "54fa3000-2595-11ec-a759-2fef1ee78d9e",
                      "to": [
                        {"email": "userb@qa.open-paas.org"},
                      ],
                      "receivedAt": "2021-10-05T04:33:04Z",
                      "header:X-MEETING-UID:asText":
                          "64fa3000-2595-11ec-a759-2fef1ee78d9e",
                    },
                  ],
                },
                "c0",
              ],
            ],
          },
          expectedBody: {
            "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:mail"],
            "methodCalls": [
              [
                "Email/get",
                {
                  "accountId":
                      "93c56f4408cff66f0a929aea8e3940e753c3275e5622582ae3010e7277b7696c",
                  "ids": ["54fa3000-2595-11ec-a759-2fef1ee78d9e"],
                  "properties": [
                    "id",
                    "subject",
                    "from",
                    "to",
                    "cc",
                    "bcc",
                    "keywords",
                    "size",
                    "receivedAt",
                    "sentAt",
                    "replyTo",
                    "preview",
                    "hasAttachment",
                    "header:X-MEETING-UID:asText",
                  ],
                },
                "c0",
              ],
            ],
          },
        );

        final jmapRequestBuilder = RequestBuilder();
        final accountId = AccountId(
          Id(
            '93c56f4408cff66f0a929aea8e3940e753c3275e5622582ae3010e7277b7696c',
          ),
        );
        final getEmailMethodForCreated = GetEmailMethod(accountId)
          ..addIds({Id('54fa3000-2595-11ec-a759-2fef1ee78d9e')})
          ..addProperties(
            Properties({
              'id',
              'subject',
              'from',
              'to',
              'cc',
              'bcc',
              'keywords',
              'size',
              'receivedAt',
              'sentAt',
              'replyTo',
              'preview',
              'hasAttachment',
              'header:X-MEETING-UID:asText',
            }),
          );
        final getEmailForCreatedInvocation = jmapRequestBuilder.addInvocation(
          getEmailMethodForCreated,
        );

        final result = await jmapRequestBuilder.build().execute(
          httpMockClient,
          MockEndpointHttpClient.endpointUri,
        );

        final resultCreated = result.parse<GetEmailResponse>(
          getEmailForCreatedInvocation.methodCallId,
          GetEmailResponse.deserialize,
        );

        expect(resultCreated.list.length, equals(1));
        expect(resultCreated.list, containsAll([expectMail]));
      },
    );
  });
}
