import 'package:jmap_dart_client/api/jmap_request.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/push/push_subscription.dart';
import 'package:jmap_dart_client/methods/push/set_push_subscription_method.dart';
import 'package:jmap_dart_client/methods/push/set_push_subscription_response.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  group('test to json set pushSubscription method', () {
    final expectedCreated = PushSubscription(
      id: PushSubscriptionId(Id('175dbd70-93d1-11ec-984e-e3f8b83572b4')),
    );

    test('set pushSubscription method and response parsing', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "PushSubscription/set",
              {
                "created": {
                  "dab246": {
                    "id": "175dbd70-93d1-11ec-984e-e3f8b83572b4",
                    "keys": null,
                    "expires": "2022-03-31T02:14:29Z",
                  },
                },
              },
              "c0",
            ],
          ],
        },
        expectedBody: {
          "using": ["urn:ietf:params:jmap:core"],
          "methodCalls": [
            [
              "PushSubscription/set",
              {
                "create": {
                  "dab246": {
                    "deviceClientId": "a123-b123-c123",
                    "url":
                        "https://example.com/push/?device=abc123&client=123abc",
                    "types": ["Mailbox", "Email"],
                  },
                },
              },
              "c0",
            ],
          ],
        },
      );

      final setPushSubscriptionMethod = SetPushSubscriptionMethod()
        ..addCreate(
          Id('dab246'),
          PushSubscription(
            deviceClientId: 'a123-b123-c123',
            url: 'https://example.com/push/?device=abc123&client=123abc',
            types: ['Mailbox', 'Email'],
          ),
        );

      final requestBuilder = JmapRequestBuilder();
      final setPushSubscriptionInvocation = requestBuilder.invocation(
        setPushSubscriptionMethod,
      );
      final response = await requestBuilder.build().execute(
        httpMockClient,
        MockEndpointHttpClient.endpointUri,
      );

      final setPushSubscriptionResponse = response
          .parse<SetPushSubscriptionResponse>(
            setPushSubscriptionInvocation.methodCallId,
            SetPushSubscriptionResponse.deserialize,
          );

      expect(
        setPushSubscriptionResponse.created![Id('dab246')]!.id,
        equals(expectedCreated.id),
      );
    });
  });
}
