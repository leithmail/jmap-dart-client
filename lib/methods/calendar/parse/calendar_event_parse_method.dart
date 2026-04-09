import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/parse_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/calendar/parse/calendar_event_parse_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/properties_converter.dart';

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
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(accountId),
      'blobIds': blobIds.map(const IdConverter().toJson).toList(),
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('properties', const PropertiesConverter().toJson(properties));

    return val;
  }

  @override
  CalendarEventParseResponse responseFromJson(Map<String, dynamic> json) {
    return CalendarEventParseResponse.fromJson(json);
  }
}
