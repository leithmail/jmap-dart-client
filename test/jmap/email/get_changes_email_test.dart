import 'package:jmap_dart_client/api/properties/properties.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request_builder.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/entities/core/utc_date.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/entities/email/email_address.dart';
import 'package:jmap_dart_client/entities/email/keyword_identifier.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/methods/email/changes_email_method.dart';
import 'package:jmap_dart_client/methods/email/get_email_method.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  group('[Email/changes]', () {
    final expectMail1 = Email(
      id: EmailId(Id("a59d5ca0-258e-11ec-a759-2fef1ee78d9e")),
      mailboxIds: {MailboxId(Id('aba7e8d0-18d9-11eb-a677-2990b970028d')): true},
      keywords: {KeyWordIdentifier.emailSeen: true},
    );

    final expectMail2 = Email(
      id: EmailId(Id("a59d5ca0-258e-11ec-a759-2fef1ee78d9e")),
      preview:
          "This event is about to begin test TimeTuesday 29 September 2020 06:00 - 06:30 Europe/Paris (See in Calendar)Location1 thai ha (See in Map)Attendees - User A <usera@qa.open-paas.org> (Organizer) -  <userb@qa.open-paas.org> Resourcesnew directoryNotesaaaa *#",
      hasAttachment: false,
      size: UnsignedInt(24946),
      subject: "Notification: test",
      keywords: {KeyWordIdentifier.emailSeen: true},
      from: {EmailAddress(null, "noreply@qa.open-paas.org")},
      to: {EmailAddress(null, "userb@qa.open-paas.org")},
      sentAt: UTCDate(DateTime.parse("2021-10-05T03:45:01Z")),
      receivedAt: UTCDate(DateTime.parse("2021-10-05T03:45:13Z")),
    );

    final expectMail3 = Email(
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
    );

    test('get changes email', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "Email/changes",
              {
                "accountId":
                    "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                "oldState": "57c15230-2588-11ec-a759-2fef1ee78d9e",
                "newState": "561dc870-2595-11ec-a759-2fef1ee78d9e",
                "hasMoreChanges": false,
                "created": [
                  "a59d5ca0-258e-11ec-a759-2fef1ee78d9e",
                  "54fa3000-2595-11ec-a759-2fef1ee78d9e",
                ],
                "updated": ["a59d5ca0-258e-11ec-a759-2fef1ee78d9e"],
                "destroyed": [],
              },
              "c1",
            ],
            [
              "Email/get",
              {
                "accountId":
                    "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                "notFound": [],
                "state": "561dc870-2595-11ec-a759-2fef1ee78d9e",
                "list": [
                  {
                    "keywords": {"\$seen": true},
                    "mailboxIds": {
                      "aba7e8d0-18d9-11eb-a677-2990b970028d": true,
                    },
                    "id": "a59d5ca0-258e-11ec-a759-2fef1ee78d9e",
                  },
                ],
              },
              "c2",
            ],
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
                        "This event is about to begin test TimeTuesday 29 September 2020 06:00 - 06:30 Europe/Paris (See in Calendar)Location1 thai ha (See in Map)Attendees - User A <usera@qa.open-paas.org> (Organizer) -  <userb@qa.open-paas.org> Resourcesnew directoryNotesaaaa *#",
                    "hasAttachment": false,
                    "size": 24946,
                    "keywords": {"\$seen": true},
                    "subject": "Notification: test",
                    "from": [
                      {"email": "noreply@qa.open-paas.org"},
                    ],
                    "sentAt": "2021-10-05T03:45:01Z",
                    "id": "a59d5ca0-258e-11ec-a759-2fef1ee78d9e",
                    "to": [
                      {"email": "userb@qa.open-paas.org"},
                    ],
                    "receivedAt": "2021-10-05T03:45:13Z",
                  },
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
                  },
                ],
              },
              "c3",
            ],
          ],
        },
        expectedBody: {
          "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:mail"],
          "methodCalls": [
            [
              "Email/changes",
              {
                "accountId":
                    "93c56f4408cff66f0a929aea8e3940e753c3275e5622582ae3010e7277b7696c",
                "sinceState": "57c15230-2588-11ec-a759-2fef1ee78d9e",
              },
              "c1",
            ],
            [
              "Email/get",
              {
                "accountId":
                    "93c56f4408cff66f0a929aea8e3940e753c3275e5622582ae3010e7277b7696c",
                "#ids": {
                  "resultOf": "c1",
                  "name": "Email/changes",
                  "path": "/updated",
                },
                "properties": ["mailboxIds", "keywords"],
              },
              "c2",
            ],
            [
              "Email/get",
              {
                "accountId":
                    "93c56f4408cff66f0a929aea8e3940e753c3275e5622582ae3010e7277b7696c",
                "#ids": {
                  "resultOf": "c1",
                  "name": "Email/changes",
                  "path": "/created",
                },
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
                ],
              },
              "c3",
            ],
          ],
        },
      );

      final jmapRequestBuilder = RequestBuilder();
      final accountId = AccountId(
        Id('93c56f4408cff66f0a929aea8e3940e753c3275e5622582ae3010e7277b7696c'),
      );
      final state = State('57c15230-2588-11ec-a759-2fef1ee78d9e');

      final changesEmailMethod = ChangesEmailMethod(accountId, state);
      final changesEmailInvocation = jmapRequestBuilder.addInvocation(
        changesEmailMethod,
        methodCallId: MethodCallId('c1'),
      );

      final getEmailMethodForUpdate = GetEmailMethod(accountId)
        ..addProperties(Properties({'mailboxIds', 'keywords'}))
        ..addReferenceIds(changesEmailInvocation, ReferencePath('/updated'));
      final getEmailForUpdateInvocation = jmapRequestBuilder.addInvocation(
        getEmailMethodForUpdate,
        methodCallId: MethodCallId('c2'),
      );

      final getEmailMethodForCreated = GetEmailMethod(accountId)
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
          }),
        )
        ..addReferenceIds(changesEmailInvocation, ReferencePath('/created'));
      final getEmailForCreatedInvocation = jmapRequestBuilder.addInvocation(
        getEmailMethodForCreated,
        methodCallId: MethodCallId('c3'),
      );

      final result = await jmapRequestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final resultUpdated = getEmailForUpdateInvocation.parse(result);

      final resultCreated = getEmailForCreatedInvocation.parse(result);

      expect(resultUpdated.list[0], equals(expectMail1));
      expect(resultCreated.list[0], equals(expectMail2));
      expect(resultCreated.list[1], equals(expectMail3));
    });
  });
}
