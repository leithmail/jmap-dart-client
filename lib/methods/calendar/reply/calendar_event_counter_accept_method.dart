import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/calendar_event_reply_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/calendar/reply/calendar_event_accept_response.dart';

class CalendarEventCounterAcceptMethod
    extends CalendarEventReplyMethod<CalendarEventAcceptResponse> {
  CalendarEventCounterAcceptMethod(super.accountId, {required super.blobIds});

  @override
  MethodName methodName() => MethodName('CalendarEventCounter/accept');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jamesCalendarEvent,
  };

  @override
  CalendarEventAcceptResponse responseFromJson(Map<String, dynamic> json) {
    return CalendarEventAcceptResponse.fromJson(json);
  }
}
