import 'package:jmap_dart_client/entities/identity/identity.dart';
import 'package:jmap_dart_client/src/converters/identities/identity_id_converter.dart';
import 'package:json_annotation/json_annotation.dart';

class PublicAssetIdentitiesConverter
    extends JsonConverter<Map<IdentityId, bool>, Map<String, dynamic>> {
  const PublicAssetIdentitiesConverter();

  @override
  Map<IdentityId, bool> fromJson(Map<String, dynamic> json) {
    return Map.fromEntries(
      json.entries.map(
        (entry) => MapEntry(
          const IdentityIdConverter().fromJson(entry.key),
          entry.value,
        ),
      ),
    );
  }

  @override
  Map<String, bool> toJson(Map<IdentityId, bool> object) {
    return Map.fromEntries(
      object.entries.map(
        (entry) => MapEntry(
          const IdentityIdConverter().toJson(entry.key),
          entry.value,
        ),
      ),
    );
  }
}
