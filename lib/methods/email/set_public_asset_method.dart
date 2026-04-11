import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/email/public_asset.dart';
import 'package:jmap_dart_client/methods/email/set_public_asset_response.dart';

class SetPublicAssetMethod
    extends SetMethod<SetPublicAssetResponse, PublicAsset> {
  SetPublicAssetMethod(super.accountId);

  @override
  MethodName methodName() => MethodName('PublicAsset/set');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapPublicAsset,
  };

  @override
  SetPublicAssetResponse responseFromJson(Map<String, dynamic> json) {
    return SetPublicAssetResponse.fromJson(json);
  }

  @override
  Object? typeToJson(PublicAsset v) => v.toJson();
}
