// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoreCapability _$CoreCapabilityFromJson(Map<String, dynamic> json) =>
    CoreCapability(
      maxSizeUpload: const UnsignedIntNullableConverter()
          .fromJson((json['maxSizeUpload'] as num?)?.toInt()),
      maxConcurrentUpload: const UnsignedIntNullableConverter()
          .fromJson((json['maxConcurrentUpload'] as num?)?.toInt()),
      maxSizeRequest: const UnsignedIntNullableConverter()
          .fromJson((json['maxSizeRequest'] as num?)?.toInt()),
      maxConcurrentRequests: const UnsignedIntNullableConverter()
          .fromJson((json['maxConcurrentRequests'] as num?)?.toInt()),
      maxCallsInRequest: const UnsignedIntNullableConverter()
          .fromJson((json['maxCallsInRequest'] as num?)?.toInt()),
      maxObjectsInGet: const UnsignedIntNullableConverter()
          .fromJson((json['maxObjectsInGet'] as num?)?.toInt()),
      maxObjectsInSet: const UnsignedIntNullableConverter()
          .fromJson((json['maxObjectsInSet'] as num?)?.toInt()),
      collationAlgorithms: (json['collationAlgorithms'] as List<dynamic>?)
          ?.map(
              (e) => const CollationIdentifierConverter().fromJson(e as String))
          .toSet(),
    );

Map<String, dynamic> _$CoreCapabilityToJson(CoreCapability instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('maxSizeUpload',
      const UnsignedIntNullableConverter().toJson(instance.maxSizeUpload));
  writeNotNull(
      'maxConcurrentUpload',
      const UnsignedIntNullableConverter()
          .toJson(instance.maxConcurrentUpload));
  writeNotNull('maxSizeRequest',
      const UnsignedIntNullableConverter().toJson(instance.maxSizeRequest));
  writeNotNull(
      'maxConcurrentRequests',
      const UnsignedIntNullableConverter()
          .toJson(instance.maxConcurrentRequests));
  writeNotNull('maxCallsInRequest',
      const UnsignedIntNullableConverter().toJson(instance.maxCallsInRequest));
  writeNotNull('maxObjectsInGet',
      const UnsignedIntNullableConverter().toJson(instance.maxObjectsInGet));
  writeNotNull('maxObjectsInSet',
      const UnsignedIntNullableConverter().toJson(instance.maxObjectsInSet));
  writeNotNull(
      'collationAlgorithms',
      instance.collationAlgorithms
          ?.map(const CollationIdentifierConverter().toJson)
          .toList());
  return val;
}
