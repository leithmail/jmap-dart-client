import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/capability/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/properties_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_calendar_event_attendance_method.g.dart';

@JsonSerializable(
  converters: [IdConverter(), AccountIdConverter(), PropertiesConverter()],
  explicitToJson: true,
)
class GetCalendarEventAttendanceMethod extends GetMethod {
  GetCalendarEventAttendanceMethod(super.accountId, this.blobIds);

  final List<Id> blobIds;

  @override
  MethodName get methodName => MethodName('CalendarEventAttendance/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jamesCalendarEvent,
  };

  factory GetCalendarEventAttendanceMethod.fromJson(
    Map<String, dynamic> json,
  ) => _$GetCalendarEventAttendanceMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$GetCalendarEventAttendanceMethodToJson(this);
}
