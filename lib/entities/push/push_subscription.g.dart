// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushSubscription _$PushSubscriptionFromJson(Map<String, dynamic> json) =>
    PushSubscription(
      id: json['id'] == null
          ? null
          : Id<PushSubscription>.fromJson(json['id'] as String),
      deviceClientId: json['deviceClientId'] as String?,
      url: json['url'] as String?,
      keys: json['keys'] == null
          ? null
          : EncryptionKey.fromJson(json['keys'] as Map<String, dynamic>),
      verificationCode: json['verificationCode'] as String?,
      expires: json['expires'] == null
          ? null
          : UTCDate.fromJson(json['expires'] as String),
      types: (json['types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PushSubscriptionToJson(PushSubscription instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'deviceClientId': ?instance.deviceClientId,
      'url': ?instance.url,
      'keys': ?instance.keys,
      'verificationCode': ?instance.verificationCode,
      'expires': ?instance.expires,
      'types': ?instance.types,
    };
