import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/capability_properties.dart';

import 'package:json_annotation/json_annotation.dart';

part 'submission_capability.g.dart';

@JsonSerializable(createToJson: false)
class SubmissionCapability extends CapabilityProperties with EquatableMixin {
  final int? maxDelayedSend;
  final Map<String, List<String>>? submissionExtensions;

  SubmissionCapability({
    this.maxDelayedSend,
    Map<String, List<String>>? submissionExtensions,
  }) : submissionExtensions = submissionExtensions == null
           ? null
           : Map.unmodifiable(submissionExtensions);

  factory SubmissionCapability.fromJson(Map<String, dynamic> json) =>
      _$SubmissionCapabilityFromJson(json);

  @override
  List<Object?> get props => [maxDelayedSend, submissionExtensions];
}
