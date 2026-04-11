import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/identity/identity.dart';
import 'package:jmap_dart_client/methods/identity/set_identity_response.dart';

class SetIdentityMethod extends SetMethod<SetIdentityResponse, Identity> {
  SetIdentityMethod(AccountId accountId) : super(accountId);

  @override
  MethodName methodName() => MethodName('Identity/set');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapSubmission,
  };

  @override
  Object? typeToJson(Identity v) => v.toJson();

  @override
  SetIdentityResponse responseFromJson(Map<String, dynamic> json) {
    return SetIdentityResponse.fromJson(json);
  }
}
