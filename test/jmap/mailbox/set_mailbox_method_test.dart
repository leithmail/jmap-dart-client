import 'package:jmap_dart_client/api/request_builder.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/methods/mailbox/set/set_mailbox_method.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  group('test to json set mailbox method', () {
    final expectedCreated = Mailbox(
      id: MailboxId(Id('175dbd70-93d1-11ec-984e-e3f8b83572b4')),
    );

    test('set mailbox method and response parsing', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "Mailbox/set",
              {
                "accountId":
                    "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                "oldState": "b33eaa50-93cd-11ec-984e-e3f8b83572b4",
                "created": {
                  "dab246": {
                    "id": "175dbd70-93d1-11ec-984e-e3f8b83572b4",
                    "sortOrder": 1000,
                    "totalEmails": 0,
                    "unreadEmails": 0,
                    "totalThreads": 0,
                    "unreadThreads": 0,
                    "myRights": {
                      "mayReadItems": true,
                      "mayAddItems": true,
                      "mayRemoveItems": true,
                      "maySetSeen": true,
                      "maySetKeywords": true,
                      "mayCreateChild": true,
                      "mayRename": true,
                      "mayDelete": true,
                      "maySubmit": true,
                    },
                    "isSubscribed": true,
                  },
                },
                "newState": "175ea7d0-93d1-11ec-984e-e3f8b83572b4",
              },
              "c0",
            ],
          ],
        },
        expectedBody: {
          "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:mail"],
          "methodCalls": [
            [
              "Mailbox/set",
              {
                "accountId":
                    "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                "create": {
                  "dab246": {
                    "name": "dab135",
                    "parentId": "aba7e8d0-18d9-11eb-a677-2990b970028d",
                  },
                },
              },
              "c0",
            ],
          ],
        },
      );

      final setMailboxMethod =
          SetMailboxMethod(
            AccountId(
              Id(
                '3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12',
              ),
            ),
          )..addCreate(
            Id('dab246'),
            Mailbox(
              name: MailboxName('dab135'),
              parentId: MailboxId(Id('aba7e8d0-18d9-11eb-a677-2990b970028d')),
            ),
          );

      final requestBuilder = RequestBuilder();
      final setMailboxInvocation = requestBuilder.addInvocation(
        setMailboxMethod,
      );
      final response = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final setMailboxResponse = setMailboxInvocation.parse(response);

      expect(
        setMailboxResponse.created![Id('dab246')]!.id,
        equals(expectedCreated.id),
      );
    });
  });
}
