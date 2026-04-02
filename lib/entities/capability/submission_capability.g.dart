// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmissionCapability _$SubmissionCapabilityFromJson(
  Map<String, dynamic> json,
) => SubmissionCapability(
  maxDelayedSend: const UnsignedIntNullableConverter().fromJson(
    (json['maxDelayedSend'] as num?)?.toInt(),
  ),
  submissionExtensions: (json['submissionExtensions'] as Map<String, dynamic>?)
      ?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
);

Map<String, dynamic> _$SubmissionCapabilityToJson(
  SubmissionCapability instance,
) => <String, dynamic>{
  'maxDelayedSend': ?const UnsignedIntNullableConverter().toJson(
    instance.maxDelayedSend,
  ),
  'submissionExtensions': ?instance.submissionExtensions,
};
