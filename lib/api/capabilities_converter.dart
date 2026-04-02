import 'package:built_collection/built_collection.dart';
import 'package:jmap_dart_client/entities/capability/calendar_event_capability.dart';
import 'package:jmap_dart_client/entities/capability/core_capability.dart';
import 'package:jmap_dart_client/entities/capability/default_capability.dart';
import 'package:jmap_dart_client/entities/capability/empty_capability.dart';
import 'package:jmap_dart_client/entities/capability/mail_capability.dart';
import 'package:jmap_dart_client/entities/capability/mdn_capability.dart';
import 'package:jmap_dart_client/entities/capability/submission_capability.dart';
import 'package:jmap_dart_client/entities/capability/vacation_capability.dart';
import 'package:jmap_dart_client/entities/capability/web_socket_ticket_capability.dart';
import 'package:jmap_dart_client/entities/capability/websocket_capability.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/capability_properties.dart';

class CapabilitiesConverter {
  static final defaultConverter = CapabilitiesConverter();

  BuiltMap<
    CapabilityIdentifier,
    CapabilityProperties Function(Map<String, dynamic>)
  >?
  mapCapabilitiesConverter;
  final _mapCapabilityConverterBuilder =
      MapBuilder<
        CapabilityIdentifier,
        CapabilityProperties Function(Map<String, dynamic>)
      >();

  CapabilitiesConverter() {
    _mapCapabilityConverterBuilder.addAll({
      CapabilityIdentifier.jmapMail: MailCapability.fromJson,
      CapabilityIdentifier.jmapCore: CoreCapability.fromJson,
      CapabilityIdentifier.jmapSubmission: SubmissionCapability.fromJson,
      CapabilityIdentifier.jamesCalendarEvent: CalendarEventCapability.fromJson,
      CapabilityIdentifier.jmapVacationResponse: VacationCapability.fromJson,
      CapabilityIdentifier.jmapWebSocket: WebSocketCapability.fromJson,
      CapabilityIdentifier.jmapWebSocketTicket:
          WebSocketTicketCapability.fromJson,
      CapabilityIdentifier.jmapMdn: MdnCapability.fromJson,
    });
  }

  void addConverters(
    Map<
      CapabilityIdentifier,
      CapabilityProperties Function(Map<String, dynamic>)
    >
    converters,
  ) {
    _mapCapabilityConverterBuilder.addAll(converters);
  }

  void build() {
    mapCapabilitiesConverter = _mapCapabilityConverterBuilder.build();
  }

  BuiltMap<CapabilityIdentifier, Function>? getConverters() {
    return mapCapabilitiesConverter;
  }

  MapEntry<CapabilityIdentifier, CapabilityProperties> convert(
    String key,
    dynamic value,
  ) {
    if (mapCapabilitiesConverter == null) {
      build();
    }

    final identifier = CapabilityIdentifier(Uri.parse(key));
    if (mapCapabilitiesConverter!.containsKey(identifier)) {
      try {
        return MapEntry(
          identifier,
          mapCapabilitiesConverter![identifier]!.call(value),
        );
      } catch (e) {
        return MapEntry(identifier, EmptyCapability());
      }
    } else {
      return MapEntry(identifier, DefaultCapability(value));
    }
  }
}
