import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/push/push_subscription.dart';
import 'package:jmap_dart_client/methods/push/get_push_subscription_response.dart';
import 'package:jmap_dart_client/methods/push/push_subscription_property.dart';

class GetPushSubscriptionMethod
    extends Method<GetPushSubscriptionResponse, ResultReference>
    with EmptyResultReferences {
  final ids = ListSlot<PushSubscriptionId>('ids', (v) => v.value);
  final properties = ArgumentSlot<PushSubscriptionProperty>(
    'properties',
    (v) => v.value,
  );

  @override
  MethodName get methodName => MethodName('PushSubscription/get');

  @override
  GetPushSubscriptionResponse responseFromJson(Map<String, dynamic> json) {
    return GetPushSubscriptionResponse.fromJson(json);
  }

  @override
  get slots => [...super.slots, ids, properties];
}
