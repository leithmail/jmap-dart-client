import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/push/get_push_subscription_response.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/properties_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_push_subscription_method.g.dart';

@IdConverter()
@PropertiesConverter()
@JsonSerializable(createFactory: false)
class GetPushSubscriptionMethod
    extends GetMethodNoNeedAccountId<GetPushSubscriptionResponse> {
  GetPushSubscriptionMethod() : super();

  @override
  MethodName methodName() => MethodName('PushSubscription/get');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
  };

  @override
  Map<String, dynamic> toJson() => _$GetPushSubscriptionMethodToJson(this);

  @override
  GetPushSubscriptionResponse responseFromJson(Map<String, dynamic> json) {
    return GetPushSubscriptionResponse.fromJson(json);
  }
}
