import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/capability_properties.dart';

class CustomCapability extends CapabilityProperties with EquatableMixin {
  final Map<String, dynamic>? properties;

  CustomCapability(Map<String, dynamic>? properties)
    : properties = properties == null ? null : Map.unmodifiable(properties);

  @override
  List<Object?> get props => [properties];
}
