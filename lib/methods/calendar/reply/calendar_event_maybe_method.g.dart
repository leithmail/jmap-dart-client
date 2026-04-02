// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_maybe_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CalendarEventMaybeMethodToJson(
  CalendarEventMaybeMethod instance,
) => <String, dynamic>{
  'language': ?instance.language,
  'accountId': const AccountIdConverter().toJson(instance.accountId),
  'blobIds': instance.blobIds.map(const IdConverter().toJson).toList(),
};
