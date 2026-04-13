import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/capability_properties.dart';
import 'package:jmap_dart_client/entities/core/collation_identifier.dart';
import 'package:jmap_dart_client/src/converters/collation_identifier_converter.dart';

import 'package:json_annotation/json_annotation.dart';

part 'core_capability.g.dart';

@CollationIdentifierConverter()
@JsonSerializable(createToJson: false)
class CoreCapability extends CapabilityProperties with EquatableMixin {
  final int? maxSizeUpload;
  final int? maxConcurrentUpload;
  final int? maxSizeRequest;
  final int? maxConcurrentRequests;
  final int? maxCallsInRequest;
  final int? maxObjectsInGet;
  final int? maxObjectsInSet;
  final List<CollationIdentifier>? collationAlgorithms;

  CoreCapability({
    this.maxSizeUpload,
    this.maxConcurrentUpload,
    this.maxSizeRequest,
    this.maxConcurrentRequests,
    this.maxCallsInRequest,
    this.maxObjectsInGet,
    this.maxObjectsInSet,
    List<CollationIdentifier>? collationAlgorithms,
  }) : collationAlgorithms = collationAlgorithms == null
           ? null
           : List.unmodifiable(collationAlgorithms);

  factory CoreCapability.fromJson(Map<String, dynamic> json) =>
      _$CoreCapabilityFromJson(json);

  @override
  List<Object?> get props => [
    maxSizeUpload,
    maxConcurrentUpload,
    maxSizeRequest,
    maxConcurrentRequests,
    maxCallsInRequest,
    maxObjectsInGet,
    maxObjectsInSet,
    collationAlgorithms,
  ];
}
