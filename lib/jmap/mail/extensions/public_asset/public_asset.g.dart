// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicAsset _$PublicAssetFromJson(Map<String, dynamic> json) => PublicAsset(
  id: const IdNullableConverter().fromJson(json['id'] as String?),
  publicURI: json['publicURI'] as String?,
  size: (json['size'] as num?)?.toInt(),
  contentType: json['contentType'] as String?,
  blobId: const IdNullableConverter().fromJson(json['blobId'] as String?),
  identityIds:
      _$JsonConverterFromJson<Map<String, dynamic>, Map<IdentityId, bool>>(
        json['identityIds'],
        const PublicAssetIdentitiesConverter().fromJson,
      ),
);

Map<String, dynamic> _$PublicAssetToJson(PublicAsset instance) =>
    <String, dynamic>{
      'id': ?const IdNullableConverter().toJson(instance.id),
      'publicURI': ?instance.publicURI,
      'size': ?instance.size,
      'contentType': ?instance.contentType,
      'blobId': ?const IdNullableConverter().toJson(instance.blobId),
      'identityIds':
          ?_$JsonConverterToJson<Map<String, dynamic>, Map<IdentityId, bool>>(
            instance.identityIds,
            const PublicAssetIdentitiesConverter().toJson,
          ),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
