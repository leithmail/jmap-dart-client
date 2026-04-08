// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEvent _$CalendarEventFromJson(
  Map<String, dynamic> json,
) => CalendarEvent(
  eventId: const EventIdNullableConverter().fromJson(json['uid'] as String?),
  title: json['title'] as String?,
  description: json['description'] as String?,
  startDate: json['start'] == null
      ? null
      : DateTime.parse(json['start'] as String),
  endDate: json['end'] == null ? null : DateTime.parse(json['end'] as String),
  startUtcDate: const UTCDateNullableConverter().fromJson(
    json['utcStart'] as String?,
  ),
  endUtcDate: const UTCDateNullableConverter().fromJson(
    json['utcEnd'] as String?,
  ),
  duration: const CalendarDurationNullableConverter().fromJson(
    json['duration'] as String?,
  ),
  timeZone: json['timeZone'] as String?,
  location: json['location'] as String?,
  method: $enumDecodeNullable(_$EventMethodEnumMap, json['method']),
  sequence: const CalendarSequenceNullableConverter().fromJson(
    (json['sequence'] as num?)?.toInt(),
  ),
  privacy: $enumDecodeNullable(_$CalendarPrivacyEnumMap, json['privacy']),
  priority: const CalendarPriorityNullableConverter().fromJson(
    (json['priority'] as num?)?.toInt(),
  ),
  freeBusyStatus: $enumDecodeNullable(
    _$CalendarFreeBusyStatusEnumMap,
    json['freeBusyStatus'],
  ),
  status: $enumDecodeNullable(_$CalendarEventStatusEnumMap, json['status']),
  organizer: json['organizer'] == null
      ? null
      : CalendarOrganizer.fromJson(json['organizer'] as Map<String, dynamic>),
  participants: (json['participants'] as List<dynamic>?)
      ?.map((e) => CalendarAttendee.fromJson(e as Map<String, dynamic>))
      .toList(),
  extensionFields: const CalendarAttendeeExtensionFieldsNullableConverter()
      .fromJson(json['extensionFields']),
  recurrenceRules: (json['recurrenceRules'] as List<dynamic>?)
      ?.map((e) => RecurrenceRule.fromJson(e as Map<String, dynamic>))
      .toList(),
  excludedCalendarEvents: (json['excludedCalendarEvents'] as List<dynamic>?)
      ?.map((e) => RecurrenceRule.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CalendarEventToJson(
  CalendarEvent instance,
) => <String, dynamic>{
  'uid': ?const EventIdNullableConverter().toJson(instance.eventId),
  'title': ?instance.title,
  'description': ?instance.description,
  'start': ?instance.startDate?.toIso8601String(),
  'end': ?instance.endDate?.toIso8601String(),
  'utcStart': ?const UTCDateNullableConverter().toJson(instance.startUtcDate),
  'utcEnd': ?const UTCDateNullableConverter().toJson(instance.endUtcDate),
  'duration': ?const CalendarDurationNullableConverter().toJson(
    instance.duration,
  ),
  'timeZone': ?instance.timeZone,
  'location': ?instance.location,
  'method': ?_$EventMethodEnumMap[instance.method],
  'sequence': ?const CalendarSequenceNullableConverter().toJson(
    instance.sequence,
  ),
  'privacy': ?_$CalendarPrivacyEnumMap[instance.privacy],
  'priority': ?const CalendarPriorityNullableConverter().toJson(
    instance.priority,
  ),
  'freeBusyStatus': ?_$CalendarFreeBusyStatusEnumMap[instance.freeBusyStatus],
  'status': ?_$CalendarEventStatusEnumMap[instance.status],
  'organizer': ?instance.organizer,
  'participants': ?instance.participants,
  'extensionFields': ?const CalendarAttendeeExtensionFieldsNullableConverter()
      .toJson(instance.extensionFields),
  'recurrenceRules': ?instance.recurrenceRules,
  'excludedCalendarEvents': ?instance.excludedCalendarEvents,
};

const _$EventMethodEnumMap = {
  EventMethod.publish: 'PUBLISH',
  EventMethod.request: 'REQUEST',
  EventMethod.reply: 'REPLY',
  EventMethod.add: 'ADD',
  EventMethod.cancel: 'CANCEL',
  EventMethod.refresh: 'REFRESH',
  EventMethod.counter: 'COUNTER',
  EventMethod.declineCounter: 'DECLINECOUNTER',
};

const _$CalendarPrivacyEnumMap = {
  CalendarPrivacy.public: 'public',
  CalendarPrivacy.private: 'private',
  CalendarPrivacy.secret: 'secret',
};

const _$CalendarFreeBusyStatusEnumMap = {
  CalendarFreeBusyStatus.free: 'free',
  CalendarFreeBusyStatus.busy: 'busy',
};

const _$CalendarEventStatusEnumMap = {
  CalendarEventStatus.confirmed: 'confirmed',
  CalendarEventStatus.cancelled: 'cancelled',
  CalendarEventStatus.tentative: 'tentative',
};
