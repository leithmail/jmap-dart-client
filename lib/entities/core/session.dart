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

  Session(
    this.capabilities,
    this.accounts,
    this.primaryAccounts,
    this.username,
    this.apiUrl,
    this.downloadUrl,
    this.uploadUrl,
    this.eventSourceUrl,
    this.state,
  );

  factory Session.fromJson(
    Map<String, dynamic> json, {
    CapabilitiesConverter? converter,
  }) {
    converter ??= CapabilitiesConverter.defaultConverter;
    return Session(
      (json['capabilities'] as Map<String, dynamic>).map(
        (key, value) => converter!.convert(key, value),
      ),
      (json['accounts'] as Map<String, dynamic>).map(
        (key, value) =>
            const AccountConverter().convert(key, value, converter!),
      ),
      (json['primaryAccounts'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          CapabilityIdentifier(Uri.parse(key)),
          const AccountIdConverter().fromJson(value),
        ),
      ),
      const UserNameConverter().fromJson(json['username'] as String),
      Uri.parse(json['apiUrl'] as String),
      Uri.parse(json['downloadUrl'] as String),
      Uri.parse(json['uploadUrl'] as String),
      Uri.parse(json['eventSourceUrl'] as String),
      const StateConverter().fromJson(json['state'] as String),
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
