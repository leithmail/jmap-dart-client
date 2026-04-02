import 'package:built_collection/built_collection.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';

mixin RequiredUsing {
  final SetBuilder<CapabilityIdentifier> capabilitiesBuilder = SetBuilder();

  void using(CapabilityIdentifier capabilityIdentifier) {
    capabilitiesBuilder.add(capabilityIdentifier);
  }

  void addUsings(Set<CapabilityIdentifier> capabilityIdentifiers) {
    capabilitiesBuilder.addAll(capabilityIdentifiers);
  }
}
