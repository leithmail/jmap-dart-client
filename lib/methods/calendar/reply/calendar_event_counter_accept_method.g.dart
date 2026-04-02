// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_counter_accept_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CalendarEventCounterAcceptMethodToJson(
  CalendarEventCounterAcceptMethod instance,
) => <String, dynamic>{
  'language': ?instance.language,
  'accountId': const AccountIdConverter().toJson(instance.accountId),
  'blobIds': instance.blobIds.map(const IdConverter().toJson).toList(),
};
