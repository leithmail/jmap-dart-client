import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/quota/get_quota_response.dart';
import 'package:jmap_dart_client/methods/quota/quota_property.dart';

class GetQuotaMethod
    extends GetMethod<GetQuotaResponse, ResultReference, QuotaProperty>
    with EmptyResultReferences {
  GetQuotaMethod({required super.accountId});

  @override
  MethodName get methodName => MethodName('Quota/get');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapQuota,
  ];

  @override
  GetQuotaResponse responseFromJson(Map<String, dynamic> json) {
    return GetQuotaResponse.fromJson(json);
  }
}
