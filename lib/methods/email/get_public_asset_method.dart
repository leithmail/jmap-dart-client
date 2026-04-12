import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/email/get_public_asset_response.dart';

class GetPublicAssetMethod
    extends MethodRequiringAccountId<GetPublicAssetResponse>
    with OptionalIds {
  GetPublicAssetMethod(super.accountId);

  @override
  MethodName get methodName => MethodName('PublicAsset/get');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapPublicAsset,
  ];

  @override
  GetPublicAssetResponse responseFromJson(Map<String, dynamic> json) {
    return GetPublicAssetResponse.fromJson(json);
  }
}
