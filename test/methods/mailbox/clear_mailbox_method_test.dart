import 'package:jmap_dart_client/api/errors/error_method_response.dart';
import 'package:jmap_dart_client/api/errors/exceptions.dart';
import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request_builder.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/methods/mailbox/clear/clear_mailbox_method.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  final methodCallId = MethodCallId('c0');
  final bobAccountId = AccountId('bob');
  final bobTrashId = MailboxId('trash-bob');
  final sessionState = State('newState');

  group('clear mailbox method test:', () {
    test('should fail when wrong account id', () async {
      // Arrange
      final unknownAccountId = AccountId('unknownAccountId');
      final clearMailboxMethod = ClearMailboxMethod(
        accountId: Val(unknownAccountId),
        mailboxId: Val(bobTrashId),
      );
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "error",
              {"type": "accountNotFound"},
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
          "using":
              clearMailboxMethod.requiredCapabilities
                  .map((capability) => capability.value.toString())
                  .toList()
                ..sort(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {
                "accountId": unknownAccountId.value,
                "mailboxId": bobTrashId.value,
              },
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      // Assert
      expect(
        () => invocation.parseResponse(responseObject),
        throwsA(
          isA<JmapMethodErrorException>().having(
            (e) => e.errorResponse,
            'errorResponse',
            isA<AccountNotFoundMethodResponse>(),
          ),
        ),
      );
    });

    test('should fail when missing mailbox clear capability', () async {
      // Arrange
      final listCapabilitiesUsed = [
        CapabilityIdentifier.jmapCore,
        CapabilityIdentifier.jmapMail,
      ];
      final clearMailboxMethod = ClearMailboxMethod(
        accountId: Val(bobAccountId),
        mailboxId: Val(bobTrashId),
      );
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "error",
              {
                "type": "unknownMethod",
                "description":
                    "Missing capability(ies): com:linagora:params:jmap:mailbox:clear",
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
          "using":
              listCapabilitiesUsed
                  .map((capability) => capability.value.toString())
                  .toList()
                ..sort(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {"accountId": bobAccountId.value, "mailboxId": bobTrashId.value},
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
        withRequiredCapabilities: false,
      );

      // Act
      final responseObject =
          await (requestBuilder..addUsings(listCapabilitiesUsed))
              .build()
              .execute(httpMockClient, HttpMockResponseClient.defaultUri);

      // Assert
      expect(
        () => invocation.parseResponse(responseObject),
        throwsA(
          predicate<JmapMethodErrorException>((e) {
            final response = e.errorResponse;
            return response is UnknownMethodResponse &&
                response.description ==
                    'Missing capability(ies): com:linagora:params:jmap:mailbox:clear';
          }, 'JmapMethodErrorException with UnknownMethodResponse description'),
        ),
      );
    });

    test('should clear all messages in target mailbox', () async {
      // Arrange
      final clearMailboxMethod = ClearMailboxMethod(
        accountId: Val(bobAccountId),
        mailboxId: Val(bobTrashId),
      );
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "Mailbox/clear",
              {"accountId": bobAccountId.value, "totalDeletedMessagesCount": 2},
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
          "using":
              clearMailboxMethod.requiredCapabilities
                  .map((capability) => capability.value.toString())
                  .toList()
                ..sort(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {"accountId": bobAccountId.value, "mailboxId": bobTrashId.value},
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final clearMailboxResponse = invocation.parseResponse(responseObject);
      // Assert
      expect(clearMailboxResponse.totalDeletedMessagesCount, 2);
      expect(clearMailboxResponse.notCleared, isNull);
    });

    test('should fail when invalid mailbox id', () async {
      // Arrange
      final invalidMailboxId = MailboxId('invalidMailboxId');
      final clearMailboxMethod = ClearMailboxMethod(
        accountId: Val(bobAccountId),
        mailboxId: Val(invalidMailboxId),
      );
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "Mailbox/clear",
              {
                "accountId": bobAccountId.value,
                "notCleared": {
                  "type": "invalidArguments",
                  "description": "invalidMailboxId",
                },
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
          "using":
              clearMailboxMethod.requiredCapabilities
                  .map((capability) => capability.value.toString())
                  .toList()
                ..sort(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {
                "accountId": bobAccountId.value,
                "mailboxId": invalidMailboxId.value,
              },
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final clearMailboxResponse = invocation.parseResponse(responseObject);
      // Assert
      expect(clearMailboxResponse.totalDeletedMessagesCount, isNull);
      expect(clearMailboxResponse.notCleared?.type, SetError.invalidArguments);
      expect(clearMailboxResponse.notCleared?.description, 'invalidMailboxId');
    });

    test('should fail when mailbox id not found', () async {
      // Arrange
      final notFoundMailboxId = MailboxId('notFoundMailboxId');
      final clearMailboxMethod = ClearMailboxMethod(
        accountId: Val(bobAccountId),
        mailboxId: Val(notFoundMailboxId),
      );
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "Mailbox/clear",
              {
                "accountId": bobAccountId.value,
                "notCleared": {
                  "type": "notFound",
                  "description": "${notFoundMailboxId.value} can not be found",
                },
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
          "using":
              clearMailboxMethod.requiredCapabilities
                  .map((capability) => capability.value.toString())
                  .toList()
                ..sort(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {
                "accountId": bobAccountId.value,
                "mailboxId": notFoundMailboxId.value,
              },
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final clearMailboxResponse = invocation.parseResponse(responseObject);

      // Assert
      expect(clearMailboxResponse.totalDeletedMessagesCount, isNull);
      expect(clearMailboxResponse.notCleared?.type, SetError.notFound);
      expect(
        clearMailboxResponse.notCleared?.description,
        '${notFoundMailboxId.value} can not be found',
      );
    });

    test('should return serverFail error\n'
        'when exceptions are encountered during the deletion', () async {
      // Arrange
      final clearMailboxMethod = ClearMailboxMethod(
        accountId: Val(bobAccountId),
        mailboxId: Val(bobTrashId),
      );
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "Mailbox/clear",
              {
                "accountId": bobAccountId.value,
                "notCleared": {
                  "type": "serverFail",
                  "description":
                      "exception abcxyz happened while clearing ${bobTrashId.value}",
                },
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
          "using":
              clearMailboxMethod.requiredCapabilities
                  .map((capability) => capability.value.toString())
                  .toList()
                ..sort(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {"accountId": bobAccountId.value, "mailboxId": bobTrashId.value},
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final clearMailboxResponse = invocation.parseResponse(responseObject);

      // Assert
      expect(clearMailboxResponse.totalDeletedMessagesCount, isNull);
      expect(clearMailboxResponse.notCleared?.type, SetError.serverFail);
      expect(
        clearMailboxResponse.notCleared?.description,
        'exception abcxyz happened while clearing ${bobTrashId.value}',
      );
    });

    test('should succeed to clear team mailbox\n'
        'when request has share capability', () async {
      // Arrange
      final teamMailboxId = MailboxId('teamMailboxId');
      final clearMailboxMethod = ClearMailboxMethod(
        accountId: Val(bobAccountId),
        mailboxId: Val(teamMailboxId),
      );
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "Mailbox/clear",
              {"accountId": bobAccountId.value, "totalDeletedMessagesCount": 1},
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
          "using":
              clearMailboxMethod.requiredCapabilities
                  .map((capability) => capability.value.toString())
                  .toList()
                ..sort(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {
                "accountId": bobAccountId.value,
                "mailboxId": teamMailboxId.value,
              },
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject =
          await (requestBuilder
                ..addUsings(clearMailboxMethod.requiredCapabilities))
              .build()
              .execute(httpMockClient, HttpMockResponseClient.defaultUri);

      final clearMailboxResponse = invocation.parseResponse(responseObject);

      // Assert
      expect(clearMailboxResponse.totalDeletedMessagesCount, 1);
      expect(clearMailboxResponse.notCleared, isNull);
    });

    test('should fail to clear team mailbox\n'
        'when missing share capability', () async {
      // Arrange
      final teamMailboxId = MailboxId('teamMailboxId');
      final listCapabilitiesUsed = [
        CapabilityIdentifier.jmapCore,
        CapabilityIdentifier.jmapMail,
        CapabilityIdentifier.jmapMailboxClear,
      ];
      final clearMailboxMethod = ClearMailboxMethod(
        accountId: Val(bobAccountId),
        mailboxId: Val(teamMailboxId),
      );
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "Mailbox/clear",
              {
                "accountId": bobAccountId.value,
                "notCleared": {
                  "type": "notFound",
                  "description": "${teamMailboxId.value} can not be found",
                },
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
          "using":
              listCapabilitiesUsed
                  .map((capability) => capability.value.toString())
                  .toList()
                ..sort(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {
                "accountId": bobAccountId.value,
                "mailboxId": teamMailboxId.value,
              },
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject =
          await (requestBuilder..addUsings(listCapabilitiesUsed))
              .build()
              .execute(httpMockClient, HttpMockResponseClient.defaultUri);

      final clearMailboxResponse = invocation.parseResponse(responseObject);
      // Assert
      expect(clearMailboxResponse.totalDeletedMessagesCount, isNull);
      expect(clearMailboxResponse.notCleared?.type, SetError.notFound);
      expect(
        clearMailboxResponse.notCleared?.description,
        '${teamMailboxId.value} can not be found',
      );
    });
  });
}
