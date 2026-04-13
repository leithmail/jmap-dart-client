// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoreCapability _$CoreCapabilityFromJson(Map<String, dynamic> json) =>
    CoreCapability(
      maxSizeUpload: (json['maxSizeUpload'] as num?)?.toInt(),
      maxConcurrentUpload: (json['maxConcurrentUpload'] as num?)?.toInt(),
      maxSizeRequest: (json['maxSizeRequest'] as num?)?.toInt(),
      maxConcurrentRequests: (json['maxConcurrentRequests'] as num?)?.toInt(),
      maxCallsInRequest: (json['maxCallsInRequest'] as num?)?.toInt(),
      maxObjectsInGet: (json['maxObjectsInGet'] as num?)?.toInt(),
      maxObjectsInSet: (json['maxObjectsInSet'] as num?)?.toInt(),
      collationAlgorithms: (json['collationAlgorithms'] as List<dynamic>?)
          ?.map(
            (e) => const CollationIdentifierConverter().fromJson(e as String),
          )
          .toList(),
    );
