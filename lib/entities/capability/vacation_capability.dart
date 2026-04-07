import 'package:jmap_dart_client/entities/core/capability_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vacation_capability.g.dart';

@JsonSerializable(createToJson: false)
class VacationCapability extends CapabilityProperties {
  VacationCapability();

  factory VacationCapability.fromJson(Map<String, dynamic> json) =>
      _$VacationCapabilityFromJson(json);

  @override
  List<Object?> get props => [];
}
