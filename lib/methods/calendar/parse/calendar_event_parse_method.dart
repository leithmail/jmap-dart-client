import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/parse_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/calendar/parse/calendar_event_parse_response.dart';

class CalendarEventParseMethod
    extends ParseMethod<CalendarEventParseResponse, ResultReference>
    with EmptyResultReferences {
  CalendarEventParseMethod({required super.accountId, required super.blobIds});

  @override
  MethodName get methodName => MethodName('CalendarEvent/parse');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jamesCalendarEvent,
  ];

  @override
  CalendarEventParseResponse responseFromJson(Map<String, dynamic> json) {
    return CalendarEventParseResponse.fromJson(json);
  }
}
