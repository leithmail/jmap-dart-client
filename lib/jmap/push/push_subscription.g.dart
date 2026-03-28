// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushSubscription _$PushSubscriptionFromJson(Map<String, dynamic> json) =>
    PushSubscription(
      id: const PushSubscriptionIdNullableConverter().fromJson(
        json['id'] as String?,
      ),
      deviceClientId: json['deviceClientId'] as String?,
      url: json['url'] as String?,
      keys: json['keys'] == null
          ? null
          : EncryptionKey.fromJson(json['keys'] as Map<String, dynamic>),
      verificationCode: json['verificationCode'] as String?,
      expires: const UTCDateNullableConverter().fromJson(
        json['expires'] as String?,
      ),
      types: (json['types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PushSubscriptionToJson(PushSubscription instance) =>
    <String, dynamic>{
      'id': ?const PushSubscriptionIdNullableConverter().toJson(instance.id),
      'deviceClientId': ?instance.deviceClientId,
      'url': ?instance.url,
      'keys': ?instance.keys,
      'verificationCode': ?instance.verificationCode,
      'expires': ?const UTCDateNullableConverter().toJson(instance.expires),
      'types': ?instance.types,
    };
