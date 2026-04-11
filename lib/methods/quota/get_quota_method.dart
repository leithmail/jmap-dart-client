import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/quota/get_quota_response.dart';

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
  GetQuotaResponse responseFromJson(Map<String, dynamic> json) {
    return GetQuotaResponse.fromJson(json);
  }
}
