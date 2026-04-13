import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/request/patch_object.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/push/push_subscription.dart';
import 'package:jmap_dart_client/methods/push/set_push_subscription_response.dart';

class SetPushSubscriptionMethod
    extends Method<SetPushSubscriptionResponse, ResultReference>
    with EmptyResultReferences {
  SetPushSubscriptionMethod() : super();

  @override
  MethodName get methodName => MethodName('PushSubscription/set');

  @override
  SetPushSubscriptionResponse responseFromJson(Map<String, dynamic> json) {
    return SetPushSubscriptionResponse.fromJson(json);
  }

  Object? typeToJson(PushSubscription v) => v.toJson();

  final ifInState = ArgumentSlot<State>('ifInState', (v) => v.value);
  late final create = MapSlot<Id, PushSubscription>(
    'create',
    (k) => k.value,
    (v) => typeToJson(v),
  );
  final update = MapSlot<Id, PatchObject>(
    'update',
    (k) => k.value,
    (v) => v.toJson(),
  );
  final destroy = ListSlot<Id>('destroy', (v) => v.value);
  late final updateSingleton = MapSlot<Id, PushSubscription>(
    'update',
    (k) => k.value,
    (v) => typeToJson(v),
  );

  @override
  get slots => [
    ...super.slots,
    ifInState,
    create,
    update,
    destroy,
    updateSingleton,
  ];
}
