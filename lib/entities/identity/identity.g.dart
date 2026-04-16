// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Identity _$IdentityFromJson(Map<String, dynamic> json) => Identity(
  id: json['id'] == null ? null : Id<Identity>.fromJson(json['id'] as String),
  name: json['name'] as String,
  email: json['email'] as String,
  replyTo: (json['replyTo'] as List<dynamic>?)
      ?.map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
      .toList(),
  bcc: (json['bcc'] as List<dynamic>?)
      ?.map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
      .toList(),
  textSignature: json['textSignature'] as String,
  htmlSignature: json['htmlSignature'] as String,
  mayDelete: json['mayDelete'] as bool?,
);

Map<String, dynamic> _$IdentityToJson(Identity instance) => <String, dynamic>{
  'id': ?instance.id,
  'name': instance.name,
  'email': instance.email,
  'replyTo': ?instance.replyTo,
  'bcc': ?instance.bcc,
  'textSignature': instance.textSignature,
  'htmlSignature': instance.htmlSignature,
  'mayDelete': ?instance.mayDelete,
};
