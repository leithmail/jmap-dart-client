import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/capability/capability_properties.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/src/converters/unsigned_int_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submission_capability.g.dart';

@UnsignedIntNullableConverter()
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SubmissionCapability extends CapabilityProperties with EquatableMixin {
  final UnsignedInt? maxDelayedSend;
  final Map<String, List<String>>? submissionExtensions;

  SubmissionCapability({this.maxDelayedSend, this.submissionExtensions});

  factory SubmissionCapability.fromJson(Map<String, dynamic> json) =>
      _$SubmissionCapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$SubmissionCapabilityToJson(this);

  static SubmissionCapability deserialize(Map<String, dynamic> json) =>
      SubmissionCapability.fromJson(json);

  @override
  List<Object?> get props => [maxDelayedSend, submissionExtensions];
}
