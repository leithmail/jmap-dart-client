import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/identity/get_identity_response.dart';

class GetIdentityMethod extends GetMethod<GetIdentityResponse, ResultReference>
    with EmptyResultReferences {
  GetIdentityMethod({required super.accountId});

  @override
  MethodName get methodName => MethodName('Identity/get');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapSubmission,
  ];

  @override
  GetIdentityResponse responseFromJson(Map<String, dynamic> json) {
    return GetIdentityResponse.fromJson(json);
  }
}
