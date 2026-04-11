import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/identity/get_identity_response.dart';

class GetIdentityMethod extends GetMethod<GetIdentityResponse> {
  GetIdentityMethod(AccountId accountId) : super(accountId);

  @override
  MethodName methodName() => MethodName('Identity/get');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapSubmission,
  };

  @override
  GetIdentityResponse responseFromJson(Map<String, dynamic> json) {
    return GetIdentityResponse.fromJson(json);
  }
}
