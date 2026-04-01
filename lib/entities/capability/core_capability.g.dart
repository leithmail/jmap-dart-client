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

Map<String, dynamic> _$CoreCapabilityToJson(CoreCapability instance) =>
    <String, dynamic>{
      'maxSizeUpload': ?const UnsignedIntNullableConverter().toJson(
        instance.maxSizeUpload,
      ),
      'maxConcurrentUpload': ?const UnsignedIntNullableConverter().toJson(
        instance.maxConcurrentUpload,
      ),
      'maxSizeRequest': ?const UnsignedIntNullableConverter().toJson(
        instance.maxSizeRequest,
      ),
      'maxConcurrentRequests': ?const UnsignedIntNullableConverter().toJson(
        instance.maxConcurrentRequests,
      ),
      'maxCallsInRequest': ?const UnsignedIntNullableConverter().toJson(
        instance.maxCallsInRequest,
      ),
      'maxObjectsInGet': ?const UnsignedIntNullableConverter().toJson(
        instance.maxObjectsInGet,
      ),
      'maxObjectsInSet': ?const UnsignedIntNullableConverter().toJson(
        instance.maxObjectsInSet,
      ),
      'collationAlgorithms': ?instance.collationAlgorithms
          ?.map(const CollationIdentifierConverter().toJson)
          .toList(),
    };
