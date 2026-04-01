// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_maybe_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEventMaybeMethod _$CalendarEventMaybeMethodFromJson(
  Map<String, dynamic> json,
) => CalendarEventMaybeMethod(
  const AccountIdConverter().fromJson(json['accountId'] as String),
  blobIds: (json['blobIds'] as List<dynamic>)
      .map((e) => const IdConverter().fromJson(e as String))
      .toList(),
)..language = json['language'] as String?;

Map<String, dynamic> _$CalendarEventMaybeMethodToJson(
  CalendarEventMaybeMethod instance,
) => <String, dynamic>{
  'language': ?instance.language,
  'accountId': const AccountIdConverter().toJson(instance.accountId),
  'blobIds': instance.blobIds.map(const IdConverter().toJson).toList(),
};
