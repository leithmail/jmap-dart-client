import 'package:jmap_dart_client/api/method/request/calendar_event_reply_method.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/calendar/reply/calendar_event_reject_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event_reject_method.g.dart';

@JsonSerializable(converters: [AccountIdConverter(), IdConverter()])
class CalendarEventRejectMethod
    extends CalendarEventReplyMethod<CalendarEventRejectResponse> {
  CalendarEventRejectMethod(super.accountId, {required super.blobIds});

  @override
  MethodName get methodName => MethodName('CalendarEvent/reject');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jamesCalendarEvent,
  };

  @override
  Map<String, dynamic> toJson() => _$CalendarEventRejectMethodToJson(this);

  @override
  CalendarEventRejectResponse deserializeResponse(Map<String, dynamic> json) {
    return CalendarEventRejectResponse.deserialize(json);
  }
}
