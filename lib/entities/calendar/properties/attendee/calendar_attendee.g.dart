// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_attendee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarAttendee _$CalendarAttendeeFromJson(Map<String, dynamic> json) =>
    CalendarAttendee(
      name: const CalendarAttendeeNameNullableConverter().fromJson(
        json['name'] as String?,
      ),
      mailto: const CalendarAttendeeMailToNullableConverter().fromJson(
        json['mailto'] as String?,
      ),
      kind: const CalendarAttendeeKindNullableConverter().fromJson(
        json['kind'] as String?,
      ),
      role: const CalendarAttendeeRoleNullableConverter().fromJson(
        json['role'] as String?,
      ),
      participationStatus:
          const CalendarAttendeeParticipationStatusNullableConverter().fromJson(
            json['participationStatus'] as String?,
          ),
      expectReply: const CalendarAttendeeExpectReplyNullableConverter()
          .fromJson(json['expectReply'] as bool?),
    );

Map<String, dynamic> _$CalendarAttendeeToJson(
  CalendarAttendee instance,
) => <String, dynamic>{
  'name': ?const CalendarAttendeeNameNullableConverter().toJson(instance.name),
  'mailto': ?const CalendarAttendeeMailToNullableConverter().toJson(
    instance.mailto,
  ),
  'kind': ?const CalendarAttendeeKindNullableConverter().toJson(instance.kind),
  'role': ?const CalendarAttendeeRoleNullableConverter().toJson(instance.role),
  'participationStatus':
      ?const CalendarAttendeeParticipationStatusNullableConverter().toJson(
        instance.participationStatus,
      ),
  'expectReply': ?const CalendarAttendeeExpectReplyNullableConverter().toJson(
    instance.expectReply,
  ),
};
