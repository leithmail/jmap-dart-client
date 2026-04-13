import 'package:jmap_dart_client/jmap_dart_client.dart';
import 'package:jmap_dart_client/methods/calendar/argument/calendar_event_property.dart';

class GetCalendarEventAttendanceMethod
    extends
        GetMethod<
          GetCalendarEventAttendanceResponse,
          ResultReference,
          CalendarEventProperty
        >
    with EmptyResultReferences {
  final _blobIds = ListSlot<Id>('blobIds', (v) => v.value);

  GetCalendarEventAttendanceMethod({
    required super.accountId,
    required Argument<List<Id>> blobIds,
  }) {
    _blobIds(blobIds);
  }

  @override
  get slots => [...super.slots, _blobIds];

  @override
  MethodName get methodName => MethodName('CalendarEventAttendance/get');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jamesCalendarEvent,
  ];

  @override
  GetCalendarEventAttendanceResponse responseFromJson(
    Map<String, dynamic> json,
  ) {
    return GetCalendarEventAttendanceResponse.fromJson(json);
  }
}
