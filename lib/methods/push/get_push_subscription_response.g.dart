// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_push_subscription_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPushSubscriptionResponse _$GetPushSubscriptionResponseFromJson(
  Map<String, dynamic> json,
) => GetPushSubscriptionResponse(
  (json['list'] as List<dynamic>)
      .map((e) => PushSubscription.fromJson(e as Map<String, dynamic>))
      .toList(),
  (json['notFound'] as List<dynamic>?)
      ?.map((e) => const IdConverter().fromJson(e as String))
      .toList(),
);
