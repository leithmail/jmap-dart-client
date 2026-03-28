// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_push_subscription_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPushSubscriptionMethod _$GetPushSubscriptionMethodFromJson(
  Map<String, dynamic> json,
) => GetPushSubscriptionMethod()
  ..ids = (json['ids'] as List<dynamic>?)
      ?.map((e) => const IdConverter().fromJson(e as String))
      .toSet()
  ..referenceIds = json['#ids'] == null
      ? null
      : ResultReference.fromJson(json['#ids'] as Map<String, dynamic>)
  ..properties = const PropertiesConverter().fromJson(
    json['properties'] as List<String>?,
  )
  ..referenceProperties = json['#properties'] == null
      ? null
      : ResultReference.fromJson(json['#properties'] as Map<String, dynamic>);

Map<String, dynamic> _$GetPushSubscriptionMethodToJson(
  GetPushSubscriptionMethod instance,
) => <String, dynamic>{
  'ids': ?instance.ids?.map(const IdConverter().toJson).toList(),
  '#ids': ?instance.referenceIds,
  'properties': ?const PropertiesConverter().toJson(instance.properties),
  '#properties': ?instance.referenceProperties,
};
