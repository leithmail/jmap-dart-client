// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_counter_accept_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEventCounterAcceptMethod _$CalendarEventCounterAcceptMethodFromJson(
  Map<String, dynamic> json,
) => CalendarEventCounterAcceptMethod(
  const AccountIdConverter().fromJson(json['accountId'] as String),
  blobIds: (json['blobIds'] as List<dynamic>)
      .map((e) => const IdConverter().fromJson(e as String))
      .toList(),
)..language = json['language'] as String?;

Map<String, dynamic> _$CalendarEventCounterAcceptMethodToJson(
  CalendarEventCounterAcceptMethod instance,
) => <String, dynamic>{
  'language': ?instance.language,
  'accountId': const AccountIdConverter().toJson(instance.accountId),
  'blobIds': instance.blobIds.map(const IdConverter().toJson).toList(),
};
