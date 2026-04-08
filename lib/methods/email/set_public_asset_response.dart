import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/api/method/response/set_response.dart';
import 'package:jmap_dart_client/entities/email/public_asset.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/state_nullable_converter.dart';

class SetPublicAssetResponse extends SetResponse<PublicAsset> {
  SetPublicAssetResponse(
    super.accountId, {
    super.newState,
    super.created,
    super.updated,
    super.destroyed,
    super.notCreated,
    super.notUpdated,
    super.notDestroyed,
  });

  static SetPublicAssetResponse deserialize(Map<String, dynamic> json) {
    return SetPublicAssetResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      newState: const StateNullableConverter().fromJson(
        json['newState'] as String?,
      ),
      created: (json['created'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          PublicAsset.fromJson(value as Map<String, dynamic>),
        ),
      ),
      updated: (json['updated'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          value != null
              ? PublicAsset.fromJson(value as Map<String, dynamic>)
              : null,
        ),
      ),
      destroyed: (json['destroyed'] as List<dynamic>?)
          ?.map((id) => const IdConverter().fromJson(id))
          .toSet(),
      notCreated: (json['notCreated'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          SetError.fromJson(value),
        ),
      ),
      notUpdated: (json['notUpdated'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          SetError.fromJson(value),
        ),
      ),
      notDestroyed: (json['notDestroyed'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          SetError.fromJson(value),
        ),
      ),
    );
  }
}
