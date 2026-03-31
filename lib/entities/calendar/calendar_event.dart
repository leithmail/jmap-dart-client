import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/calendar/properties/attendee/calendar_attendee.dart';
import 'package:jmap_dart_client/entities/calendar/properties/calendar_duration.dart';
import 'package:jmap_dart_client/entities/calendar/properties/calendar_event_status.dart';
import 'package:jmap_dart_client/entities/calendar/properties/calendar_extension_fields.dart';
import 'package:jmap_dart_client/entities/calendar/properties/calendar_free_busy_status.dart';
import 'package:jmap_dart_client/entities/calendar/properties/calendar_organizer.dart';
import 'package:jmap_dart_client/entities/calendar/properties/calendar_priority.dart';
import 'package:jmap_dart_client/entities/calendar/properties/calendar_privacy.dart';
import 'package:jmap_dart_client/entities/calendar/properties/calendar_sequence.dart';
import 'package:jmap_dart_client/entities/calendar/properties/event_id.dart';
import 'package:jmap_dart_client/entities/calendar/properties/event_method.dart';
import 'package:jmap_dart_client/entities/calendar/properties/recurrence_rule/recurrence_rule.dart';
import 'package:jmap_dart_client/entities/core/utc_date.dart';
import 'package:jmap_dart_client/src/converters/calendar/calendar_duration_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/calendar/calendar_extension_fields_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/calendar/calendar_priority_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/calendar/calendar_sequence_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/calendar/event_id_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/utc_date_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event.g.dart';

@UTCDateNullableConverter()
@CalendarPriorityNullableConverter()
@CalendarSequenceNullableConverter()
@CalendarDurationNullableConverter()
@EventIdNullableConverter()
@CalendarAttendeeExtensionFieldsNullableConverter()
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CalendarEvent with EquatableMixin {
  @JsonKey(name: 'uid')
  final EventId? eventId;

  final String? title;
  final String? description;

  @JsonKey(name: 'start')
  final DateTime? startDate;

  @JsonKey(name: 'end')
  final DateTime? endDate;

  @JsonKey(name: 'utcStart')
  final UTCDate? startUtcDate;

  @JsonKey(name: 'utcEnd')
  final UTCDate? endUtcDate;

  final CalendarDuration? duration;
  final String? timeZone;
  final String? location;
  final EventMethod? method;
  final CalendarSequence? sequence;
  final CalendarPrivacy? privacy;
  final CalendarPriority? priority;
  final CalendarFreeBusyStatus? freeBusyStatus;
  final CalendarEventStatus? status;
  final CalendarOrganizer? organizer;
  final List<CalendarAttendee>? participants;
  final CalendarExtensionFields? extensionFields;
  final List<RecurrenceRule>? recurrenceRules;
  final List<RecurrenceRule>? excludedCalendarEvents;

  CalendarEvent({
    this.eventId,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.startUtcDate,
    this.endUtcDate,
    this.duration,
    this.timeZone,
    this.location,
    this.method,
    this.sequence,
    this.privacy,
    this.priority,
    this.freeBusyStatus,
    this.status,
    this.organizer,
    this.participants,
    this.extensionFields,
    this.recurrenceRules,
    this.excludedCalendarEvents,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventToJson(this);

  @override
  List<Object?> get props => [
    eventId,
    title,
    description,
    startDate,
    endDate,
    startUtcDate,
    endUtcDate,
    duration,
    timeZone,
    location,
    method,
    sequence,
    privacy,
    priority,
    freeBusyStatus,
    status,
    organizer,
    participants,
    extensionFields,
    recurrenceRules,
    excludedCalendarEvents,
  ];
}
