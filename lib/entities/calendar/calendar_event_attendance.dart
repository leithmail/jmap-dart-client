import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/src/converters/id_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event_attendance.g.dart';

enum AttendanceStatus { accepted, rejected, tentativelyAccepted, needsAction }

@IdNullableConverter()
@JsonSerializable(includeIfNull: false)
class CalendarEventAttendance with EquatableMixin {
  final Id? blobId;
  final AttendanceStatus? eventAttendanceStatus;
  final bool isFree;

  const CalendarEventAttendance({
    this.blobId,
    this.eventAttendanceStatus,
    this.isFree = true,
  });

  @override
  List<Object?> get props => [blobId, eventAttendanceStatus, isFree];

  factory CalendarEventAttendance.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventAttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventAttendanceToJson(this);
}
