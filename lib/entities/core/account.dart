import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/capability_properties.dart';
import 'package:jmap_dart_client/entities/core/id.dart';

class Account with EquatableMixin {
  final String name;
  final bool isPersonal;
  final bool isReadOnly;
  final Map<CapabilityIdentifier, CapabilityProperties> accountCapabilities;

  Account({
    required this.name,
    required this.isPersonal,
    required this.isReadOnly,
    required this.accountCapabilities,
  });

  @override
  List<Object> get props => [name, isPersonal, isReadOnly, accountCapabilities];
}

typedef AccountId = Id<Account>;
