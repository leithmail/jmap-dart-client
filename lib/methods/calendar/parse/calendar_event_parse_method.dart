import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/parse_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/calendar/parse/calendar_event_parse_response.dart';

class CalendarEventParseMethod extends ParseMethod<CalendarEventParseResponse> {
  CalendarEventParseMethod(super.accountId, super.blobIds);

  @override
  MethodName methodName() => MethodName('CalendarEvent/parse');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jamesCalendarEvent,
  };

  @override
  CalendarEventParseResponse responseFromJson(Map<String, dynamic> json) {
    return CalendarEventParseResponse.fromJson(json);
  }
}
