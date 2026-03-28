// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quota.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quota _$QuotaFromJson(Map<String, dynamic> json) => Quota(
  const IdConverter().fromJson(json['id'] as String),
  $enumDecode(_$ResourceTypeEnumMap, json['resourceType']),
  $enumDecode(_$ScopeEnumMap, json['scope']),
  json['name'] as String,
  used: const UnsignedIntNullableConverter().fromJson(
    (json['used'] as num?)?.toInt(),
  ),
  hardLimit: const UnsignedIntNullableConverter().fromJson(
    (json['hardLimit'] as num?)?.toInt(),
  ),
  limit: const UnsignedIntNullableConverter().fromJson(
    (json['limit'] as num?)?.toInt(),
  ),
  warnLimit: const UnsignedIntNullableConverter().fromJson(
    (json['warnLimit'] as num?)?.toInt(),
  ),
  softLimit: const UnsignedIntNullableConverter().fromJson(
    (json['softLimit'] as num?)?.toInt(),
  ),
  description: json['description'] as String?,
  types: (json['types'] as List<dynamic>?)
      ?.map((e) => const DataTypeConverter().fromJson(e as String))
      .toList(),
  dataTypes: (json['dataTypes'] as List<dynamic>?)
      ?.map((e) => const DataTypeConverter().fromJson(e as String))
      .toList(),
);

Map<String, dynamic> _$QuotaToJson(Quota instance) => <String, dynamic>{
  'id': const IdConverter().toJson(instance.id),
  'resourceType': _$ResourceTypeEnumMap[instance.resourceType]!,
  'used': ?const UnsignedIntNullableConverter().toJson(instance.used),
  'hardLimit': ?const UnsignedIntNullableConverter().toJson(instance.hardLimit),
  'limit': ?const UnsignedIntNullableConverter().toJson(instance.limit),
  'scope': _$ScopeEnumMap[instance.scope]!,
  'name': instance.name,
  'dataTypes': ?instance.dataTypes
      ?.map(const DataTypeConverter().toJson)
      .toList(),
  'types': ?instance.types?.map(const DataTypeConverter().toJson).toList(),
  'warnLimit': ?const UnsignedIntNullableConverter().toJson(instance.warnLimit),
  'softLimit': ?const UnsignedIntNullableConverter().toJson(instance.softLimit),
  'description': ?instance.description,
};

const _$ResourceTypeEnumMap = {
  ResourceType.count: 'count',
  ResourceType.octets: 'octets',
};

const _$ScopeEnumMap = {
  Scope.account: 'account',
  Scope.domain: 'domain',
  Scope.global: 'global',
};
