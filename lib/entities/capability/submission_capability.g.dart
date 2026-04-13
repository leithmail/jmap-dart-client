// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmissionCapability _$SubmissionCapabilityFromJson(
  Map<String, dynamic> json,
) => SubmissionCapability(
  maxDelayedSend: (json['maxDelayedSend'] as num?)?.toInt(),
  submissionExtensions: (json['submissionExtensions'] as Map<String, dynamic>?)
      ?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
);
