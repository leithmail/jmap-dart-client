import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/push/push_subscription.dart';
import 'package:jmap_dart_client/methods/push/set_push_subscription_response.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/set/set_method_properties_converter.dart';

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
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
  };

  @override
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull(
      'create',
      create?.map(
        (id, create) =>
            SetMethodPropertiesConverter().fromMapIdToJson(id, create.toJson()),
      ),
    );
    writeNotNull(
      'update',
      update?.map(
        (id, update) =>
            SetMethodPropertiesConverter().fromMapIdToJson(id, update.toJson()),
      ),
    );
    writeNotNull(
      'destroy',
      destroy
          ?.map((destroyId) => const IdConverter().toJson(destroyId))
          .toList(),
    );

    return val;
  }

  @override
  SetPushSubscriptionResponse responseFromJson(Map<String, dynamic> json) {
    return SetPushSubscriptionResponse.fromJson(json);
  }
}
