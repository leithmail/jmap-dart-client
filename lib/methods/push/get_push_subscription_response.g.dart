// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_push_subscription_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPushSubscriptionResponse _$GetPushSubscriptionResponseFromJson(
  Map<String, dynamic> json,
) => GetPushSubscriptionResponse(
  lisPushSubscription: (json['lisPushSubscription'] as List<dynamic>)
      .map((e) => PushSubscription.fromJson(e as Map<String, dynamic>))
      .toList(),
  notFound: (json['notFound'] as List<dynamic>?)
      ?.map((e) => Id<PushSubscription>.fromJson(e as String))
      .toList(),
);
