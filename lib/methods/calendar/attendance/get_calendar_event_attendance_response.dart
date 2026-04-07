import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/calendar/calendar_event_attendance.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/set_error_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_calendar_event_attendance_response.g.dart';

@JsonSerializable(
  includeIfNull: false,
  createToJson: false,
  converters: [
    StateConverter(),
    AccountIdConverter(),
    IdConverter(),
    SetErrorConverter(),
  ],
)
class GetCalendarEventAttendanceResponse extends ResponseRequiringAccountId {
  GetCalendarEventAttendanceResponse(
    super.accountId,
    this.list,
    this.notFound,
    this.notDone,
  );

  final List<CalendarEventAttendance> list;
  final List<Id>? notFound;
  final Map<Id, SetError>? notDone;

  @override
  List<Object?> get props => [accountId, list, notFound, notDone];

  factory GetCalendarEventAttendanceResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$GetCalendarEventAttendanceResponseFromJson(json);
}
