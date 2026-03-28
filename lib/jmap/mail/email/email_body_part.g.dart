// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_body_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailBodyPart _$EmailBodyPartFromJson(
  Map<String, dynamic> json,
) => EmailBodyPart(
  partId: const PartIdNullableConverter().fromJson(json['partId'] as String?),
  blobId: const IdNullableConverter().fromJson(json['blobId'] as String?),
  size: const UnsignedIntNullableConverter().fromJson(
    (json['size'] as num?)?.toInt(),
  ),
  headers: (json['headers'] as List<dynamic>?)
      ?.map((e) => EmailHeader.fromJson(e as Map<String, dynamic>))
      .toSet(),
  name: json['name'] as String?,
  type: const MediaTypeNullableConverter().fromJson(json['type'] as String?),
  charset: json['charset'] as String?,
  disposition: json['disposition'] as String?,
  cid: json['cid'] as String?,
  language: (json['language'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toSet(),
  location: json['location'] as String?,
  subParts: (json['subParts'] as List<dynamic>?)
      ?.map((e) => EmailBodyPart.fromJson(e as Map<String, dynamic>))
      .toSet(),
);

Map<String, dynamic> _$EmailBodyPartToJson(EmailBodyPart instance) =>
    <String, dynamic>{
      'partId': ?const PartIdNullableConverter().toJson(instance.partId),
      'blobId': ?const IdNullableConverter().toJson(instance.blobId),
      'size': ?const UnsignedIntNullableConverter().toJson(instance.size),
      'headers': ?instance.headers?.toList(),
      'name': ?instance.name,
      'type': ?const MediaTypeNullableConverter().toJson(instance.type),
      'charset': ?instance.charset,
      'disposition': ?instance.disposition,
      'cid': ?instance.cid,
      'language': ?instance.language?.toList(),
      'location': ?instance.location,
      'subParts': ?instance.subParts?.toList(),
    };
