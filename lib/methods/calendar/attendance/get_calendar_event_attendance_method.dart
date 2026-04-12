import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/jmap_dart_client.dart';

class GetCalendarEventAttendanceMethod
    extends GetMethod<GetCalendarEventAttendanceResponse, ResultReference>
    with EmptyResultReferences {
  final _blobIds = ListArgumentSlot<Id>('blobIds', (v) => v.value);

  GetCalendarEventAttendanceMethod({
    required super.accountId,
    required Argument<List<Id>> blobIds,
  }) {
    _blobIds.set(blobIds);
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
