import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/error/method/error_method_response.dart';
import 'package:jmap_dart_client/jmap/core/error/method/exception/error_method_response_exception.dart';
import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/clear/clear_mailbox_method.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/clear/clear_mailbox_response.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:test/test.dart';

import '../../../http_mocks.dart';

void main() {
  final methodCallId = MethodCallId('c0');
  final bobAccountId = AccountId(Id('bob'));
  final bobTrashId = MailboxId(Id('trash-bob'));
  final sessionState = State('newState');

  group('clear mailbox method test:', () {
    test('should fail when wrong account id', () async {
      // Arrange
      final unknownAccountId = AccountId(Id('unknownAccountId'));
      final clearMailboxMethod = ClearMailboxMethod(
        unknownAccountId,
        bobTrashId,
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
          "using": clearMailboxMethod.requiredCapabilities
              .map((capability) => capability.value.toString())
              .toList(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {
                "accountId": unknownAccountId.id.value,
                "mailboxId": bobTrashId.id.value,
              },
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = JmapRequestBuilder(
        MockEndpointHttpClient(httpMockClient),
        ProcessingInvocation(),
      );
      final invocation = requestBuilder.invocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject =
          await (requestBuilder
                ..usings(clearMailboxMethod.requiredCapabilities))
              .build()
              .execute();

      // Assert
      expect(
        () => responseObject.parse<ClearMailboxResponse>(
          invocation.methodCallId,
          ClearMailboxResponse.deserialize,
        ),
        throwsA(ErrorMethodResponseException(AccountNotFoundMethodResponse())),
      );
    });

    test('should fail when missing mailbox clear capability', () async {
      // Arrange
      final listCapabilitiesUsed = {
        CapabilityIdentifier.jmapCore,
        CapabilityIdentifier.jmapMail,
      };
      final clearMailboxMethod = ClearMailboxMethod(bobAccountId, bobTrashId);
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
          "using": listCapabilitiesUsed
              .map((capability) => capability.value.toString())
              .toList(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {
                "accountId": bobAccountId.id.value,
                "mailboxId": bobTrashId.id.value,
              },
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = JmapRequestBuilder(
        MockEndpointHttpClient(httpMockClient),
        ProcessingInvocation(),
      );
      final invocation = requestBuilder.invocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject =
          await (requestBuilder..usings(listCapabilitiesUsed))
              .build()
              .execute();

      // Assert
      expect(
        () => responseObject.parse<ClearMailboxResponse>(
          invocation.methodCallId,
          ClearMailboxResponse.deserialize,
        ),
        throwsA(
          ErrorMethodResponseException(
            UnknownMethodResponse(
              description:
                  'Missing capability(ies): com:linagora:params:jmap:mailbox:clear',
            ),
          ),
        ),
      );
    });

    test('should clear all messages in target mailbox', () async {
      // Arrange
      final clearMailboxMethod = ClearMailboxMethod(bobAccountId, bobTrashId);
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "Mailbox/clear",
              {
                "accountId": bobAccountId.id.value,
                "totalDeletedMessagesCount": 2,
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
          "using": clearMailboxMethod.requiredCapabilities
              .map((capability) => capability.value.toString())
              .toList(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {
                "accountId": bobAccountId.id.value,
                "mailboxId": bobTrashId.id.value,
              },
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = JmapRequestBuilder(
        MockEndpointHttpClient(httpMockClient),
        ProcessingInvocation(),
      );
      final invocation = requestBuilder.invocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject =
          await (requestBuilder
                ..usings(clearMailboxMethod.requiredCapabilities))
              .build()
              .execute();

      final clearMailboxResponse = responseObject.parse<ClearMailboxResponse>(
        invocation.methodCallId,
        ClearMailboxResponse.deserialize,
      );

      // Assert
      expect(clearMailboxResponse?.totalDeletedMessagesCount?.value, 2);
      expect(clearMailboxResponse?.notCleared, isNull);
    });

    test('should fail when invalid mailbox id', () async {
      // Arrange
      final invalidMailboxId = MailboxId(Id('invalidMailboxId'));
      final clearMailboxMethod = ClearMailboxMethod(
        bobAccountId,
        invalidMailboxId,
      );
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "Mailbox/clear",
              {
                "accountId": bobAccountId.id.value,
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
          "using": clearMailboxMethod.requiredCapabilities
              .map((capability) => capability.value.toString())
              .toList(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {
                "accountId": bobAccountId.id.value,
                "mailboxId": invalidMailboxId.id.value,
              },
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = JmapRequestBuilder(
        MockEndpointHttpClient(httpMockClient),
        ProcessingInvocation(),
      );
      final invocation = requestBuilder.invocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject =
          await (requestBuilder
                ..usings(clearMailboxMethod.requiredCapabilities))
              .build()
              .execute();

      final clearMailboxResponse = responseObject.parse<ClearMailboxResponse>(
        invocation.methodCallId,
        ClearMailboxResponse.deserialize,
      );

      // Assert
      expect(clearMailboxResponse?.totalDeletedMessagesCount, isNull);
      expect(clearMailboxResponse?.notCleared?.type, SetError.invalidArguments);
      expect(clearMailboxResponse?.notCleared?.description, 'invalidMailboxId');
    });

    test('should fail when mailbox id not found', () async {
      // Arrange
      final notFoundMailboxId = MailboxId(Id('notFoundMailboxId'));
      final clearMailboxMethod = ClearMailboxMethod(
        bobAccountId,
        notFoundMailboxId,
      );
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "Mailbox/clear",
              {
                "accountId": bobAccountId.id.value,
                "notCleared": {
                  "type": "notFound",
                  "description":
                      "${notFoundMailboxId.id.value} can not be found",
                },
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
          "using": clearMailboxMethod.requiredCapabilities
              .map((capability) => capability.value.toString())
              .toList(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {
                "accountId": bobAccountId.id.value,
                "mailboxId": notFoundMailboxId.id.value,
              },
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = JmapRequestBuilder(
        MockEndpointHttpClient(httpMockClient),
        ProcessingInvocation(),
      );
      final invocation = requestBuilder.invocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject =
          await (requestBuilder
                ..usings(clearMailboxMethod.requiredCapabilities))
              .build()
              .execute();

      final clearMailboxResponse = responseObject.parse<ClearMailboxResponse>(
        invocation.methodCallId,
        ClearMailboxResponse.deserialize,
      );

      // Assert
      expect(clearMailboxResponse?.totalDeletedMessagesCount, isNull);
      expect(clearMailboxResponse?.notCleared?.type, SetError.notFound);
      expect(
        clearMailboxResponse?.notCleared?.description,
        '${notFoundMailboxId.id.value} can not be found',
      );
    });

    test('should return serverFail error\n'
        'when exceptions are encountered during the deletion', () async {
      // Arrange
      final clearMailboxMethod = ClearMailboxMethod(bobAccountId, bobTrashId);
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "Mailbox/clear",
              {
                "accountId": bobAccountId.id.value,
                "notCleared": {
                  "type": "serverFail",
                  "description":
                      "exception abcxyz happened while clearing ${bobTrashId.id.value}",
                },
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
          "using": clearMailboxMethod.requiredCapabilities
              .map((capability) => capability.value.toString())
              .toList(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {
                "accountId": bobAccountId.id.value,
                "mailboxId": bobTrashId.id.value,
              },
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = JmapRequestBuilder(
        MockEndpointHttpClient(httpMockClient),
        ProcessingInvocation(),
      );
      final invocation = requestBuilder.invocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject =
          await (requestBuilder
                ..usings(clearMailboxMethod.requiredCapabilities))
              .build()
              .execute();

      final clearMailboxResponse = responseObject.parse<ClearMailboxResponse>(
        invocation.methodCallId,
        ClearMailboxResponse.deserialize,
      );

      // Assert
      expect(clearMailboxResponse?.totalDeletedMessagesCount, isNull);
      expect(clearMailboxResponse?.notCleared?.type, SetError.serverFail);
      expect(
        clearMailboxResponse?.notCleared?.description,
        'exception abcxyz happened while clearing ${bobTrashId.id.value}',
      );
    });

    test('should succeed to clear team mailbox\n'
        'when request has share capability', () async {
      // Arrange
      final teamMailboxId = MailboxId(Id('teamMailboxId'));
      final clearMailboxMethod = ClearMailboxMethod(
        bobAccountId,
        teamMailboxId,
      );
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "Mailbox/clear",
              {
                "accountId": bobAccountId.id.value,
                "totalDeletedMessagesCount": 1,
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
          "using": clearMailboxMethod.requiredCapabilitiesSupportTeamMailboxes
              .map((capability) => capability.value.toString())
              .toList(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {
                "accountId": bobAccountId.id.value,
                "mailboxId": teamMailboxId.id.value,
              },
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = JmapRequestBuilder(
        MockEndpointHttpClient(httpMockClient),
        ProcessingInvocation(),
      );
      final invocation = requestBuilder.invocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject =
          await (requestBuilder..usings(
                clearMailboxMethod.requiredCapabilitiesSupportTeamMailboxes,
              ))
              .build()
              .execute();

      final clearMailboxResponse = responseObject.parse<ClearMailboxResponse>(
        invocation.methodCallId,
        ClearMailboxResponse.deserialize,
      );

      // Assert
      expect(clearMailboxResponse?.totalDeletedMessagesCount?.value, 1);
      expect(clearMailboxResponse?.notCleared, isNull);
    });

    test('should fail to clear team mailbox\n'
        'when missing share capability', () async {
      // Arrange
      final teamMailboxId = MailboxId(Id('teamMailboxId'));
      final listCapabilitiesUsed = {
        CapabilityIdentifier.jmapCore,
        CapabilityIdentifier.jmapMail,
        CapabilityIdentifier.jmapMailboxClear,
      };
      final clearMailboxMethod = ClearMailboxMethod(
        bobAccountId,
        teamMailboxId,
      );
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": sessionState.value,
          "methodResponses": [
            [
              "Mailbox/clear",
              {
                "accountId": bobAccountId.id.value,
                "notCleared": {
                  "type": "notFound",
                  "description": "${teamMailboxId.id.value} can not be found",
                },
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
          "using": listCapabilitiesUsed
              .map((capability) => capability.value.toString())
              .toList(),
          "methodCalls": [
            [
              clearMailboxMethod.methodName.value,
              {
                "accountId": bobAccountId.id.value,
                "mailboxId": teamMailboxId.id.value,
              },
              methodCallId.value,
            ],
          ],
        },
      );
      final requestBuilder = JmapRequestBuilder(
        MockEndpointHttpClient(httpMockClient),
        ProcessingInvocation(),
      );
      final invocation = requestBuilder.invocation(
        clearMailboxMethod,
        methodCallId: methodCallId,
      );

      // Act
      final responseObject =
          await (requestBuilder..usings(listCapabilitiesUsed))
              .build()
              .execute();

      final clearMailboxResponse = responseObject.parse<ClearMailboxResponse>(
        invocation.methodCallId,
        ClearMailboxResponse.deserialize,
      );

      // Assert
      expect(clearMailboxResponse?.totalDeletedMessagesCount, isNull);
      expect(clearMailboxResponse?.notCleared?.type, SetError.notFound);
      expect(
        clearMailboxResponse?.notCleared?.description,
        '${teamMailboxId.id.value} can not be found',
      );
    });
  });
}
