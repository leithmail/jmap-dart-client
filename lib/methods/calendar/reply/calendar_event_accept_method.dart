import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/calendar_event_reply_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/calendar/reply/calendar_event_accept_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event_accept_method.g.dart';

@AccountIdConverter()
@IdConverter()
@JsonSerializable(createFactory: false)
class CalendarEventAcceptMethod
    extends CalendarEventReplyMethod<CalendarEventAcceptResponse> {
  CalendarEventAcceptMethod(super.accountId, {required super.blobIds});

  @override
  MethodName methodName() => MethodName('CalendarEvent/accept');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jamesCalendarEvent,
  };

  @override
  Map<String, dynamic> toJson() => _$CalendarEventAcceptMethodToJson(this);

  @override
  CalendarEventAcceptResponse responseFromJson(Map<String, dynamic> json) {
    return CalendarEventAcceptResponse.fromJson(json);
  }
}
