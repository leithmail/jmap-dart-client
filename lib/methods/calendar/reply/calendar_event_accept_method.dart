import 'package:jmap_dart_client/api/method/request/calendar_event_reply_method.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/calendar/reply/calendar_event_accept_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event_accept_method.g.dart';

@JsonSerializable(
  createFactory: false,
  converters: [AccountIdConverter(), IdConverter()],
)
class CalendarEventAcceptMethod
    extends CalendarEventReplyMethod<CalendarEventAcceptResponse> {
  CalendarEventAcceptMethod(super.accountId, {required super.blobIds});

  @override
  @JsonKey(includeToJson: false)
  MethodName get methodName => MethodName('CalendarEvent/accept');

  @override
  @JsonKey(includeToJson: false)
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jamesCalendarEvent,
  };

  @override
  Map<String, dynamic> toJson() => _$CalendarEventAcceptMethodToJson(this);

  @override
  CalendarEventAcceptResponse deserializeResponse(Map<String, dynamic> json) {
    return CalendarEventAcceptResponse.deserialize(json);
  }
}
