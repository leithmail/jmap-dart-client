import 'package:jmap_dart_client/api/jmap_request.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/push/push_subscription.dart';
import 'package:jmap_dart_client/methods/push/get_push_subscription_method.dart';
import 'package:jmap_dart_client/methods/push/get_push_subscription_response.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  group('test to json get pushSubscription method', () {
    final expectedGet = PushSubscription(
      id: PushSubscriptionId(Id('e50b2c1d-9553-41a3-b0a7-a7d26b599ee1')),
    );

    test('get pushSubscription method and response parsing', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "PushSubscription/set",
              {
                "list": [
                  {
                    "id": "e50b2c1d-9553-41a3-b0a7-a7d26b599ee1",
                    "deviceClientId": "b37ff8001ca0",
                    "verificationCode": "b210ef734fe5f439c1ca386421359f7b",
                    "expires": "2018-07-31T00:13:21Z",
                    "types": ["Todo"],
                  },
                ],
                "notFound": [],
              },
              "c0",
            ],
          ],
        },
        expectedBody: {
          "using": ["urn:ietf:params:jmap:core"],
          "methodCalls": [
            [
              "PushSubscription/get",
              {
                "ids": ["e50b2c1d-9553-41a3-b0a7-a7d26b599ee1"],
              },
              "c0",
            ],
          ],
        },
      );

      final getPushSubscriptionMethod = GetPushSubscriptionMethod()
        ..addIds({Id('e50b2c1d-9553-41a3-b0a7-a7d26b599ee1')});

      final requestBuilder = JmapRequestBuilder(ProcessingInvocation());
      final getPushSubscriptionInvocation = requestBuilder.invocation(
        getPushSubscriptionMethod,
      );
      final response = await requestBuilder.build().execute(
        httpMockClient,
        MockEndpointHttpClient.endpointUri,
      );

      final getPushSubscriptionResponse = response
          .parse<GetPushSubscriptionResponse>(
            getPushSubscriptionInvocation.methodCallId,
            GetPushSubscriptionResponse.deserialize,
          );

      expect(getPushSubscriptionResponse.list.first.id, equals(expectedGet.id));
    });
  });
}
