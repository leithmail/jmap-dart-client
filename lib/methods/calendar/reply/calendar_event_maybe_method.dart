import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/calendar_event_reply_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/calendar/reply/calendar_event_maybe_response.dart';

class CalendarEventMaybeMethod
    extends CalendarEventReplyMethod<CalendarEventMaybeResponse> {
  CalendarEventMaybeMethod(super.accountId, {required super.blobIds});

  @override
  MethodName methodName() => MethodName('CalendarEvent/maybe');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jamesCalendarEvent,
  };

  @override
  CalendarEventMaybeResponse responseFromJson(Map<String, dynamic> json) {
    return CalendarEventMaybeResponse.fromJson(json);
  }
}
