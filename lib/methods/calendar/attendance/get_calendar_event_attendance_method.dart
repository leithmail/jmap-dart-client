import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/methods/calendar/attendance/get_calendar_event_attendance_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/properties_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_calendar_event_attendance_method.g.dart';

@IdConverter()
@AccountIdConverter()
@PropertiesConverter()
@JsonSerializable()
class GetCalendarEventAttendanceMethod
    extends GetMethod<GetCalendarEventAttendanceResponse> {
  GetCalendarEventAttendanceMethod(super.accountId, this.blobIds);

  final List<Id> blobIds;

  @override
  MethodName get methodName => MethodName('CalendarEventAttendance/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jamesCalendarEvent,
  };

  factory GetCalendarEventAttendanceMethod.fromJson(
    Map<String, dynamic> json,
  ) => _$GetCalendarEventAttendanceMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$GetCalendarEventAttendanceMethodToJson(this);

  @override
  GetCalendarEventAttendanceResponse responseFromJson(
    Map<String, dynamic> json,
  ) {
    return GetCalendarEventAttendanceResponse.fromJson(json);
  }
}
