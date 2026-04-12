import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/calendar_event_reply_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/calendar/reply/calendar_event_reject_response.dart';

class CalendarEventRejectMethod
    extends CalendarEventReplyMethod<CalendarEventRejectResponse> {
  CalendarEventRejectMethod(super.accountId, {required super.blobIds});

  @override
  MethodName get methodName => MethodName('CalendarEvent/reject');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jamesCalendarEvent,
  ];

  @override
  CalendarEventRejectResponse responseFromJson(Map<String, dynamic> json) {
    return CalendarEventRejectResponse.fromJson(json);
  }
}
