import 'package:jmap_dart_client/api/method/response/get_response.dart';
import 'package:jmap_dart_client/entities/email/public_asset.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_public_asset_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable(createToJson: false)
class GetPublicAssetResponse extends GetResponse<PublicAsset> {
  GetPublicAssetResponse(
    super.accountId,
    super.state,
    super.list,
    super.notFound,
  );

  @override
  List<Object?> get props => [accountId, state, list, notFound];

  factory GetPublicAssetResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPublicAssetResponseFromJson(json);
}
