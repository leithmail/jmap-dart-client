// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEventAttendance _$CalendarEventAttendanceFromJson(
  Map<String, dynamic> json,
) => CalendarEventAttendance(
  blobId: const IdNullableConverter().fromJson(json['blobId'] as String?),
  eventAttendanceStatus: $enumDecodeNullable(
    _$AttendanceStatusEnumMap,
    json['eventAttendanceStatus'],
  ),
  isFree: json['isFree'] as bool? ?? true,
);

Map<String, dynamic> _$CalendarEventAttendanceToJson(
  CalendarEventAttendance instance,
) => <String, dynamic>{
  'blobId': ?const IdNullableConverter().toJson(instance.blobId),
  'eventAttendanceStatus':
      ?_$AttendanceStatusEnumMap[instance.eventAttendanceStatus],
  'isFree': instance.isFree,
};

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.accepted: 'accepted',
  AttendanceStatus.rejected: 'rejected',
  AttendanceStatus.tentativelyAccepted: 'tentativelyAccepted',
  AttendanceStatus.needsAction: 'needsAction',
};
