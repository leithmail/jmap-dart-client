// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoreCapability _$CoreCapabilityFromJson(Map<String, dynamic> json) =>
    CoreCapability(
      maxSizeUpload: const UnsignedIntNullableConverter().fromJson(
        (json['maxSizeUpload'] as num?)?.toInt(),
      ),
      maxConcurrentUpload: const UnsignedIntNullableConverter().fromJson(
        (json['maxConcurrentUpload'] as num?)?.toInt(),
      ),
      maxSizeRequest: const UnsignedIntNullableConverter().fromJson(
        (json['maxSizeRequest'] as num?)?.toInt(),
      ),
      maxConcurrentRequests: const UnsignedIntNullableConverter().fromJson(
        (json['maxConcurrentRequests'] as num?)?.toInt(),
      ),
      maxCallsInRequest: const UnsignedIntNullableConverter().fromJson(
        (json['maxCallsInRequest'] as num?)?.toInt(),
      ),
      maxObjectsInGet: const UnsignedIntNullableConverter().fromJson(
        (json['maxObjectsInGet'] as num?)?.toInt(),
      ),
      maxObjectsInSet: const UnsignedIntNullableConverter().fromJson(
        (json['maxObjectsInSet'] as num?)?.toInt(),
      ),
      collationAlgorithms: (json['collationAlgorithms'] as List<dynamic>?)
          ?.map(
            (e) => const CollationIdentifierConverter().fromJson(e as String),
          )
          .toSet(),
    );
