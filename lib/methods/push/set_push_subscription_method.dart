import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/entities/push/push_subscription.dart';
import 'package:jmap_dart_client/methods/push/set_push_subscription_response.dart';

class SetPushSubscriptionMethod
    extends
        SetMethodNoNeedAccountId<
          SetPushSubscriptionResponse,
          PushSubscription
        > {
  SetPushSubscriptionMethod() : super();

  @override
  MethodName get methodName => MethodName('PushSubscription/set');

  @override
  SetPushSubscriptionResponse responseFromJson(Map<String, dynamic> json) {
    return SetPushSubscriptionResponse.fromJson(json);
  }

  @override
  Object? typeToJson(PushSubscription v) => v.toJson();
}
