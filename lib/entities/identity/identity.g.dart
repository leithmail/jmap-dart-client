// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Identity _$IdentityFromJson(Map<String, dynamic> json) => Identity(
  id: const IdentityIdNullableConverter().fromJson(json['id'] as String?),
  description: json['description'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  bcc: (json['bcc'] as List<dynamic>?)
      ?.map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
      .toSet(),
  replyTo: (json['replyTo'] as List<dynamic>?)
      ?.map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
      .toSet(),
  textSignature: const SignatureNullableConverter().fromJson(
    json['textSignature'] as String?,
  ),
  htmlSignature: const SignatureNullableConverter().fromJson(
    json['htmlSignature'] as String?,
  ),
  mayDelete: json['mayDelete'] as bool?,
  sortOrder: const UnsignedIntNullableConverter().fromJson(
    (json['sortOrder'] as num?)?.toInt(),
  ),
);

Map<String, dynamic> _$IdentityToJson(Identity instance) => <String, dynamic>{
  'id': ?const IdentityIdNullableConverter().toJson(instance.id),
  'description': ?instance.description,
  'name': ?instance.name,
  'email': ?instance.email,
  'bcc': ?instance.bcc?.toList(),
  'replyTo': ?instance.replyTo?.toList(),
  'textSignature': ?const SignatureNullableConverter().toJson(
    instance.textSignature,
  ),
  'htmlSignature': ?const SignatureNullableConverter().toJson(
    instance.htmlSignature,
  ),
  'mayDelete': ?instance.mayDelete,
  'sortOrder': ?const UnsignedIntNullableConverter().toJson(instance.sortOrder),
};
