// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_reject_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CalendarEventRejectMethodToJson(
  CalendarEventRejectMethod instance,
) => <String, dynamic>{
  'language': ?instance.language,
  'accountId': const AccountIdConverter().toJson(instance.accountId),
  'blobIds': instance.blobIds.map(const IdConverter().toJson).toList(),
};
