import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/capability/calendar_event_capability.dart';
import 'package:jmap_dart_client/entities/capability/core_capability.dart';
import 'package:jmap_dart_client/entities/capability/custom_capability.dart';
import 'package:jmap_dart_client/entities/capability/mail_capability.dart';
import 'package:jmap_dart_client/entities/capability/mdn_capability.dart';
import 'package:jmap_dart_client/entities/capability/submission_capability.dart';
import 'package:jmap_dart_client/entities/capability/vacation_capability.dart';
import 'package:jmap_dart_client/entities/capability/web_socket_ticket_capability.dart';
import 'package:jmap_dart_client/entities/capability/websocket_capability.dart';
import 'package:jmap_dart_client/entities/core/account.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/capability_properties.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/core/user_name.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/account_name_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:jmap_dart_client/src/converters/user_name_converter.dart';
import 'package:meta/meta.dart';

@immutable
class Session with EquatableMixin {
  final Map<CapabilityIdentifier, CapabilityProperties> capabilities;
  final Map<AccountId, Account> accounts;
  final Map<CapabilityIdentifier, AccountId> primaryAccounts;
  final UserName username;
  final Uri apiUrl;
  final Uri downloadUrl;
  final Uri uploadUrl;
  final Uri eventSourceUrl;
  final State state;

  Session({
    required Map<CapabilityIdentifier, CapabilityProperties> capabilities,
    required Map<AccountId, Account> accounts,
    required Map<CapabilityIdentifier, AccountId> primaryAccounts,
    required this.username,
    required this.apiUrl,
    required this.downloadUrl,
    required this.uploadUrl,
    required this.eventSourceUrl,
    required this.state,
  }) : capabilities = Map.unmodifiable(capabilities),
       accounts = Map.unmodifiable(accounts),
       primaryAccounts = Map.unmodifiable(primaryAccounts);

  factory Session.fromJson(
    Map<String, dynamic> json, {
    Map<
      CapabilityIdentifier,
      CapabilityProperties Function(Map<String, dynamic>)
    >?
    customCapabilityConverters,
  }) {
    final converter = _CapabilitiesConverter(customCapabilityConverters);
    return Session(
      capabilities: (json['capabilities'] as Map<String, dynamic>).map(
        (key, value) => converter.convert(key, value),
      ),
      accounts: (json['accounts'] as Map<String, dynamic>).map(
        (key, value) =>
            const _AccountConverter().convert(key, value, converter),
      ),
      primaryAccounts: (json['primaryAccounts'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          CapabilityIdentifier(Uri.parse(key)),
          const AccountIdConverter().fromJson(value),
        ),
      ),
      username: const UserNameConverter().fromJson(json['username'] as String),
      apiUrl: Uri.parse(json['apiUrl'] as String),
      downloadUrl: Uri.parse(json['downloadUrl'] as String),
      uploadUrl: Uri.parse(json['uploadUrl'] as String),
      eventSourceUrl: Uri.parse(json['eventSourceUrl'] as String),
      state: const StateConverter().fromJson(json['state'] as String),
    );
  }

  @override
  List<Object?> get props => [
    capabilities,
    accounts,
    primaryAccounts,
    username,
    apiUrl,
    downloadUrl,
    uploadUrl,
    eventSourceUrl,
    state,
  ];
}

class _CapabilitiesConverter {
  final Map<
    CapabilityIdentifier,
    CapabilityProperties Function(Map<String, dynamic>)
  >
  _converters = {
    CapabilityIdentifier.jmapMail: MailCapability.fromJson,
    CapabilityIdentifier.jmapCore: CoreCapability.fromJson,
    CapabilityIdentifier.jmapSubmission: SubmissionCapability.fromJson,
    CapabilityIdentifier.jamesCalendarEvent: CalendarEventCapability.fromJson,
    CapabilityIdentifier.jmapVacationResponse: VacationCapability.fromJson,
    CapabilityIdentifier.jmapWebSocket: WebSocketCapability.fromJson,
    CapabilityIdentifier.jmapWebSocketTicket:
        WebSocketTicketCapability.fromJson,
    CapabilityIdentifier.jmapMdn: MdnCapability.fromJson,
  };

  _CapabilitiesConverter([
    Map<
      CapabilityIdentifier,
      CapabilityProperties Function(Map<String, dynamic>)
    >?
    customConverters,
  ]) {
    if (customConverters != null) {
      _converters.addAll(customConverters);
    }
  }

  MapEntry<CapabilityIdentifier, CapabilityProperties> convert(
    String key,
    dynamic value,
  ) {
    final identifier = CapabilityIdentifier(Uri.parse(key));
    final converter = _converters[identifier];
    if (converter != null) {
      return MapEntry(identifier, converter.call(value));
    } else {
      return MapEntry(identifier, CustomCapability(value));
    }
  }
}

class _AccountConverter {
  const _AccountConverter();

  MapEntry<AccountId, Account> convert(
    String key,
    dynamic value,
    _CapabilitiesConverter converter,
  ) {
    final accountId = AccountId(Id(key));
    final account = accountFromJson(value, converter);
    return MapEntry(accountId, account);
  }

  Account accountFromJson(
    Map<String, dynamic> json,
    _CapabilitiesConverter converter,
  ) {
    return Account(
      name: const AccountNameConverter().fromJson(json['name'] as String),
      isPersonal: json['isPersonal'] as bool,
      isReadOnly: json['isReadOnly'] as bool,
      accountCapabilities: (json['accountCapabilities'] as Map<String, dynamic>)
          .map((key, value) => converter.convert(key, value)),
    );
  }
}
