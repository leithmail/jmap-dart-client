import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
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
  MethodName methodName() => MethodName('PushSubscription/set');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
  };

  @override
  SetPushSubscriptionResponse responseFromJson(Map<String, dynamic> json) {
    return SetPushSubscriptionResponse.fromJson(json);
  }

  @override
  Object? typeToJson(PushSubscription v) => v.toJson();
}
