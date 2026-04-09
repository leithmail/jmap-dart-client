import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/quota/get_quota_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/properties_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_quota_method.g.dart';

@IdConverter()
@AccountIdConverter()
@PropertiesConverter()
@JsonSerializable(createFactory: false)
class GetQuotaMethod extends GetMethod<GetQuotaResponse> {
  GetQuotaMethod(AccountId accountId) : super(accountId);

  @override
  MethodName methodName() => MethodName('Quota/get');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapQuota,
  };

  @override
  Map<String, dynamic> toJson() => _$GetQuotaMethodToJson(this);

  @override
  GetQuotaResponse responseFromJson(Map<String, dynamic> json) {
    return GetQuotaResponse.fromJson(json);
  }
}
