import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/email/get_public_asset_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_public_asset_method.g.dart';

@JsonSerializable(
  createFactory: false,
  converters: [AccountIdConverter(), IdConverter()],
)
class GetPublicAssetMethod
    extends MethodRequiringAccountId<GetPublicAssetResponse>
    with OptionalIds {
  GetPublicAssetMethod(super.accountId);

  @override
  @JsonKey(includeToJson: false)
  MethodName get methodName => MethodName('PublicAsset/get');

  @override
  @JsonKey(includeToJson: false)
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapPublicAsset,
  };

  @override
  Map<String, dynamic> toJson() => _$GetPublicAssetMethodToJson(this);

  @override
  GetPublicAssetResponse deserializeResponse(Map<String, dynamic> json) {
    return GetPublicAssetResponse.fromJson(json);
  }
}
