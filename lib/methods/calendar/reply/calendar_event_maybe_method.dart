import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/calendar_event_reply_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/calendar/reply/calendar_event_maybe_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event_maybe_method.g.dart';

@AccountIdConverter()
@IdConverter()
@JsonSerializable(createFactory: false)
class CalendarEventMaybeMethod
    extends CalendarEventReplyMethod<CalendarEventMaybeResponse> {
  CalendarEventMaybeMethod(super.accountId, {required super.blobIds});

  @override
  @JsonKey(includeToJson: false)
  MethodName get methodName => MethodName('CalendarEvent/maybe');

  @override
  @JsonKey(includeToJson: false)
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jamesCalendarEvent,
  };

  @override
  Map<String, dynamic> toJson() => _$CalendarEventMaybeMethodToJson(this);

  @override
  CalendarEventMaybeResponse responseFromJson(Map<String, dynamic> json) {
    return CalendarEventMaybeResponse.deserialize(json);
  }
}
