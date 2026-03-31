import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/capability/capability_identifier.dart';
import 'package:jmap_dart_client/entities/capability/capability_properties.dart';
import 'package:jmap_dart_client/entities/core/account.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/core/user_name.dart';
import 'package:jmap_dart_client/src/converters/account_converter.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/capabilities_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:jmap_dart_client/src/converters/user_name_converter.dart';

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
    required this.capabilities,
    required this.accounts,
    required this.primaryAccounts,
    required this.username,
    required this.apiUrl,
    required this.downloadUrl,
    required this.uploadUrl,
    required this.eventSourceUrl,
    required this.state,
  });

  factory Session.fromJson(
    Map<String, dynamic> json, {
    CapabilitiesConverter? converter,
  }) {
    converter ??= CapabilitiesConverter.defaultConverter;
    return Session(
      capabilities: (json['capabilities'] as Map<String, dynamic>).map(
        (key, value) => converter!.convert(key, value),
      ),
      accounts: (json['accounts'] as Map<String, dynamic>).map(
        (key, value) =>
            const AccountConverter().convert(key, value, converter!),
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
