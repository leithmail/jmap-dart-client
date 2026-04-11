import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/capability_properties.dart';
import 'package:jmap_dart_client/entities/core/collation_identifier.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/src/converters/collation_identifier_converter.dart';
import 'package:jmap_dart_client/src/converters/unsigned_int_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'core_capability.g.dart';

@CollationIdentifierConverter()
@UnsignedIntNullableConverter()
@JsonSerializable(createToJson: false)
class CoreCapability extends CapabilityProperties with EquatableMixin {
  final UnsignedInt? maxSizeUpload;
  final UnsignedInt? maxConcurrentUpload;
  final UnsignedInt? maxSizeRequest;
  final UnsignedInt? maxConcurrentRequests;
  final UnsignedInt? maxCallsInRequest;
  final UnsignedInt? maxObjectsInGet;
  final UnsignedInt? maxObjectsInSet;
  final Set<CollationIdentifier>? collationAlgorithms;

  CoreCapability({
    this.maxSizeUpload,
    this.maxConcurrentUpload,
    this.maxSizeRequest,
    this.maxConcurrentRequests,
    this.maxCallsInRequest,
    this.maxObjectsInGet,
    this.maxObjectsInSet,
    Set<CollationIdentifier>? collationAlgorithms,
  }) : collationAlgorithms = collationAlgorithms == null
           ? null
           : Set.unmodifiable(collationAlgorithms);

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
