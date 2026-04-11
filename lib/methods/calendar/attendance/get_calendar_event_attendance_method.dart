import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/methods/calendar/attendance/get_calendar_event_attendance_response.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';

class GetCalendarEventAttendanceMethod
    extends GetMethod<GetCalendarEventAttendanceResponse> {
  GetCalendarEventAttendanceMethod(super.accountId, List<Id> blobIds) {
    this.blobIds.set(blobIds);
  }

  final blobIds = ArgumentSlot<List<Id>>(
    'blobIds',
    (v) => v.map(const IdConverter().toJson).toList(),
  );

  @override
  get slots => [...super.slots, blobIds];

  @override
  MethodName methodName() => MethodName('CalendarEventAttendance/get');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jamesCalendarEvent,
  };

  @override
  GetCalendarEventAttendanceResponse responseFromJson(
    Map<String, dynamic> json,
  ) {
    return GetCalendarEventAttendanceResponse.fromJson(json);
  }
}
