import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/identity/get_identity_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/properties_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_identity_method.g.dart';

@IdConverter()
@AccountIdConverter()
@PropertiesConverter()
@JsonSerializable()
class GetIdentityMethod extends GetMethod<GetIdentityResponse> {
  GetIdentityMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('Identity/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapSubmission,
  };

  Set<CapabilityIdentifier> get requiredCapabilitiesSupportSortOrder => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapSubmission,
    CapabilityIdentifier.jamesSortOrder,
  };

  factory GetIdentityMethod.fromJson(Map<String, dynamic> json) =>
      _$GetIdentityMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetIdentityMethodToJson(this);

  @override
  GetIdentityResponse responseFromJson(Map<String, dynamic> json) {
    return GetIdentityResponse.deserialize(json);
  }
}
