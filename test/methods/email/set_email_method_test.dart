import 'package:http_parser/http_parser.dart';
import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/request_builder.dart';
import 'package:jmap_dart_client/entities/core/account.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/entities/email/email_address.dart';
import 'package:jmap_dart_client/entities/email/email_body_part.dart';
import 'package:jmap_dart_client/entities/email/email_body_value.dart';
import 'package:jmap_dart_client/entities/email/email_keyword.dart';
import 'package:jmap_dart_client/entities/email/individual_header_identifier.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/entities/thread/thread.dart';
import 'package:jmap_dart_client/methods/email/set_email_method.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  group('test to json set email method', () {
    final expectedCreated = Email(
      id: EmailId('29a7f870-0596-11ec-b153-2fef1ee78d9e'),
      blobId: BlobId('29a7f870-0596-11ec-b153-2fef1ee78d9e'),
      threadId: ThreadId('29a7f870-0596-11ec-b153-2fef1ee78d9e'),
      size: 657,
    );

    test('set email method and response parsing', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "Email/set",
              {
                "accountId":
                    "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                "oldState": "234c9ee0-0596-11ec-b153-2fef1ee78d9e",
                "newState": "234c9ee0-0596-11ec-b153-2fef1ee78d9e",
                "created": {
                  "aa1234": {
                    "id": "29a7f870-0596-11ec-b153-2fef1ee78d9e",
                    "blobId": "29a7f870-0596-11ec-b153-2fef1ee78d9e",
                    "threadId": "29a7f870-0596-11ec-b153-2fef1ee78d9e",
                    "size": 657,
                  },
                },
              },
              "c0",
            ],
          ],
        },
        expectedBody: {
          'using': ['urn:ietf:params:jmap:core', 'urn:ietf:params:jmap:mail'],
          'methodCalls': [
            [
              'Email/set',
              {
                'accountId':
                    '3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12',
                'create': {
                  'aa1234': {
                    'id': 'ea12345',
                    'mailboxIds': {
                      'fe00a5c0-0584-11ec-b153-2fef1ee78d9e': true,
                    },
                    'keywords': {'\$seen': true},
                    'subject': 'set email 3',
                    'sender': [
                      {'name': 'bob', 'email': 'bob@email'},
                    ],
                    'from': [
                      {'name': 'alice', 'email': 'alice@email'},
                    ],
                    'to': [
                      {'name': 'dcu', 'email': 'dcu@email'},
                    ],
                    'replyTo': [
                      {'name': 'bob', 'email': 'bob@email'},
                    ],
                    'htmlBody': [
                      {'partId': 'a49d', 'type': 'text/html'},
                    ],
                    'bodyValues': {
                      'a49d': {
                        'value': 'test html html',
                        'isEncodingProblem': false,
                        'isTruncated': false,
                      },
                    },
                  },
                },
              },
              'c0',
            ],
          ],
        },
      );

      final setEmailMethod =
          SetEmailMethod(
            accountId: Val(
              AccountId(
                '3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12',
              ),
            ),
          )..create(
            Val({
              EmailCreationId('aa1234'): Email(
                id: EmailId('ea12345'),
                mailboxIds: {
                  MailboxId('fe00a5c0-0584-11ec-b153-2fef1ee78d9e'): true,
                },
                keywords: {EmailKeyword.seen: true},
                replyTo: [EmailAddress(name: 'bob', email: 'bob@email')],
                from: [EmailAddress(name: 'alice', email: 'alice@email')],
                sender: [EmailAddress(name: 'bob', email: 'bob@email')],
                to: [EmailAddress(name: 'dcu', email: 'dcu@email')],
                subject: 'set email 3',
                htmlBody: [
                  EmailBodyPart(
                    partId: EmailBodyPartId('a49d'),
                    type: MediaType.parse('text/html'),
                  ),
                ],
                bodyValues: {
                  EmailBodyPartId('a49d'): EmailBodyValue(
                    value: 'test html html',
                    isEncodingProblem: false,
                    isTruncated: false,
                  ),
                },
              ),
            }),
          );

      final requestBuilder = RequestBuilder();
      final setEmailInvocation = requestBuilder.addInvocation(setEmailMethod);
      final response = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final setEmailResponse = setEmailInvocation.parseResponse(response);
      expect(
        setEmailResponse.created![EmailCreationId('aa1234')],
        equals(expectedCreated),
      );
    });

    test('set email method and response parsing with header User-Agent', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "Email/set",
              {
                "accountId":
                    "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                "oldState": "234c9ee0-0596-11ec-b153-2fef1ee78d9e",
                "newState": "234c9ee0-0596-11ec-b153-2fef1ee78d9e",
                "created": {
                  "aa1234": {
                    "id": "29a7f870-0596-11ec-b153-2fef1ee78d9e",
                    "blobId": "29a7f870-0596-11ec-b153-2fef1ee78d9e",
                    "threadId": "29a7f870-0596-11ec-b153-2fef1ee78d9e",
                    "size": 657,
                  },
                },
              },
              "c0",
            ],
          ],
        },
        expectedBody: {
          'using': ['urn:ietf:params:jmap:core', 'urn:ietf:params:jmap:mail'],
          'methodCalls': [
            [
              'Email/set',
              {
                'accountId':
                    '3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12',
                'create': {
                  'aa1234': {
                    'id': 'ea12345',
                    'mailboxIds': {
                      'fe00a5c0-0584-11ec-b153-2fef1ee78d9e': true,
                    },
                    'keywords': {'\$seen': true},
                    'subject': 'set email 3',
                    'sender': [
                      {'name': 'bob', 'email': 'bob@email'},
                    ],
                    'from': [
                      {'name': 'alice', 'email': 'alice@email'},
                    ],
                    'to': [
                      {'name': 'dcu', 'email': 'dcu@email'},
                    ],
                    'replyTo': [
                      {'name': 'bob', 'email': 'bob@email'},
                    ],
                    'htmlBody': [
                      {'partId': 'a49d', 'type': 'text/html'},
                    ],
                    'bodyValues': {
                      'a49d': {
                        'value': 'test html html',
                        'isEncodingProblem': false,
                        'isTruncated': false,
                      },
                    },
                    'header:User-Agent:asText': 'Android/1.0.0 TeamMail/1.0',
                  },
                },
              },
              'c0',
            ],
          ],
        },
      );

      final setEmailMethod =
          SetEmailMethod(
            accountId: Val(
              AccountId(
                '3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12',
              ),
            ),
          )..create(
            Val({
              EmailCreationId('aa1234'): Email(
                id: EmailId('ea12345'),
                mailboxIds: {
                  MailboxId('fe00a5c0-0584-11ec-b153-2fef1ee78d9e'): true,
                },
                keywords: {EmailKeyword.seen: true},
                replyTo: [EmailAddress(name: 'bob', email: 'bob@email')],
                from: [EmailAddress(name: 'alice', email: 'alice@email')],
                sender: [EmailAddress(name: 'bob', email: 'bob@email')],
                to: [EmailAddress(name: 'dcu', email: 'dcu@email')],
                subject: 'set email 3',
                htmlBody: [
                  EmailBodyPart(
                    partId: EmailBodyPartId('a49d'),
                    type: MediaType.parse('text/html'),
                  ),
                ],
                bodyValues: {
                  EmailBodyPartId('a49d'): EmailBodyValue(
                    value: 'test html html',
                    isEncodingProblem: false,
                    isTruncated: false,
                  ),
                },
                headerUserAgent: {
                  IndividualHeaderIdentifier.headerUserAgent:
                      'Android/1.0.0 TeamMail/1.0',
                },
              ),
            }),
          );

      final requestBuilder = RequestBuilder();
      final setEmailInvocation = requestBuilder.addInvocation(setEmailMethod);
      final response = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final setEmailResponse = setEmailInvocation.parseResponse(response);
      expect(
        setEmailResponse.created![EmailCreationId('aa1234')],
        equals(expectedCreated),
      );
    });

    test('set email method and response parsing with header Mdn', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "Email/set",
              {
                "accountId":
                    "587a9c5a4a9c0a4d36243b7417700d5383cbbfa25f0909ab7f6f4baaa5bf4e9b",
                "oldState": "24152b20-4ab0-11ed-88ee-ffc86e0cde67",
                "newState": "24152b20-4ab0-11ed-88ee-ffc86e0cde67",
                "created": {
                  "e01": {
                    "id": "77664010-4ab1-11ed-88ee-ffc86e0cde67",
                    "blobId": "77664010-4ab1-11ed-88ee-ffc86e0cde67",
                    "threadId": "77664010-4ab1-11ed-88ee-ffc86e0cde67",
                    "size": 600,
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
              "Email/set",
              {
                "accountId":
                    "587a9c5a4a9c0a4d36243b7417700d5383cbbfa25f0909ab7f6f4baaa5bf4e9b",
                "create": {
                  "e01": {
                    "id": "e102",
                    "mailboxIds": {
                      "a6f488c0-964b-11ec-83d6-c1ded34233a9": true,
                    },
                    "subject": "[POSTMAN] SEND EMAIL WITH MDN MDN MDN",
                    "from": [
                      {
                        "name": "qkdo@linagora.com",
                        "email": "qkdo@linagora.com",
                      },
                    ],
                    "htmlBody": [
                      {"partId": "abc123", "type": "text/html"},
                    ],
                    "bodyValues": {
                      "abc123": {
                        "value": "[POSTMAN] SEND EMAIL WITH MDN",
                        "isEncodingProblem": false,
                        "isTruncated": false,
                      },
                    },
                    "header:Disposition-Notification-To:asText":
                        "qkdo@linagora.com",
                    "header:Return-Path:asText": "qkdo@linagora.com",
                  },
                },
              },
              "c0",
            ],
          ],
        },
      );

      final setEmailMethod =
          SetEmailMethod(
            accountId: Val(
              AccountId(
                '587a9c5a4a9c0a4d36243b7417700d5383cbbfa25f0909ab7f6f4baaa5bf4e9b',
              ),
            ),
          )..create(
            Val({
              EmailCreationId('e01'): Email(
                id: EmailId('e102'),
                mailboxIds: {
                  MailboxId('a6f488c0-964b-11ec-83d6-c1ded34233a9'): true,
                },
                from: [
                  EmailAddress(
                    name: 'qkdo@linagora.com',
                    email: 'qkdo@linagora.com',
                  ),
                ],
                subject: '[POSTMAN] SEND EMAIL WITH MDN MDN MDN',
                htmlBody: [
                  EmailBodyPart(
                    partId: EmailBodyPartId('abc123'),
                    type: MediaType.parse('text/html'),
                  ),
                ],
                bodyValues: {
                  EmailBodyPartId('abc123'): EmailBodyValue(
                    value: '[POSTMAN] SEND EMAIL WITH MDN',
                    isEncodingProblem: false,
                    isTruncated: false,
                  ),
                },
                headerMdn: {
                  IndividualHeaderIdentifier.headerMdn: "qkdo@linagora.com",
                },
                headerReturnPath: {
                  IndividualHeaderIdentifier.headerReturnPath:
                      "qkdo@linagora.com",
                },
              ),
            }),
          );

      final requestBuilder = RequestBuilder();
      final setEmailInvocation = requestBuilder.addInvocation(setEmailMethod);
      final response = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final setEmailResponse = setEmailInvocation.parseResponse(response);
      final expectedCreated1 = Email(
        id: EmailId("77664010-4ab1-11ed-88ee-ffc86e0cde67"),
        blobId: BlobId("77664010-4ab1-11ed-88ee-ffc86e0cde67"),
        threadId: ThreadId("77664010-4ab1-11ed-88ee-ffc86e0cde67"),
        size: 600,
      );

      expect(
        setEmailResponse.created![EmailCreationId('e01')],
        equals(expectedCreated1),
      );
    });
  });
}
