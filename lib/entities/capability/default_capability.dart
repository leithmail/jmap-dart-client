import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/capability/capability_properties.dart';

class DefaultCapability extends CapabilityProperties with EquatableMixin {
  final Map<String, dynamic>? properties;

  DefaultCapability(this.properties);

  @override
  List<Object?> get props => [properties];
}
