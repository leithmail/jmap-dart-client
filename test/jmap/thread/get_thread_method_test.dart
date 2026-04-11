import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request_builder.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/entities/thread/thread.dart';
import 'package:jmap_dart_client/methods/thread/get_thread_method.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  final accountId = AccountId(Id('123abc'));
  final foundId = Id('found-thread-id');
  final emailIdFound = EmailId(Id('email-id-found'));
  final foundThread = Thread(id: ThreadId(foundId), emailIds: [emailIdFound]);
  final notFoundId = Id('not-found-thread-id');
  final getThreadMethod = GetThreadMethod(accountId)
    ..setIds({foundId, notFoundId});
  final methodCallId = MethodCallId('c0');

  group('get thread method test:', () {
    test('should return list email id '
        'when thread found '
        'and return not found '
        'when thread not found', () async {
      // arrange
      final sampleRequest = {
        "using":
            getThreadMethod
                .requiredCapabilities()
                .map((capability) => capability.value.toString())
                .toList()
              ..sort(),
        "methodCalls": [
          [
            getThreadMethod.methodName().value,
            {
              "accountId": accountId.id.value,
              "ids": {foundId.value, notFoundId.value}.toList(),
            },
            methodCallId.value,
          ],
        ],
      };
      final sampleResponse = {
        "sessionState": "abcdefghij",
        "methodResponses": [
          [
            getThreadMethod.methodName().value,
            {
              "accountId": accountId.id.value,
              "state": "state",
              "list": [foundThread.toJson()],
              "notFound": [notFoundId.value],
            },
            methodCallId.value,
          ],
        ],
      };

      final httpMockClient = HttpMockResponseClient(
        responseBody: sampleResponse,
        expectedBody: sampleRequest,
      );

      final requestBuilder = RequestBuilder();

      // act
      final invocation = requestBuilder.addInvocation(
        getThreadMethod,
        methodCallId: methodCallId,
      );
      final responseObject = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );
      final response = invocation.parseResponse(responseObject);

      // assert
      expect(response.accountId, accountId);
      expect(response.state, State('state'));
      expect(response.list, [foundThread]);
      expect(response.notFound, [notFoundId]);
    });
  });
}
