import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/capability_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mdn_capability.g.dart';

@JsonSerializable(createToJson: false)
class MdnCapability extends CapabilityProperties with EquatableMixin {
  MdnCapability();

  factory MdnCapability.fromJson(Map<String, dynamic> json) =>
      _$MdnCapabilityFromJson(json);

  @override
  List<Object?> get props => [];
}
