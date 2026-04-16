// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quota.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quota _$QuotaFromJson(Map<String, dynamic> json) => Quota(
  Id<dynamic>.fromJson(json['id'] as String),
  $enumDecode(_$ResourceTypeEnumMap, json['resourceType']),
  $enumDecode(_$ScopeEnumMap, json['scope']),
  json['name'] as String,
  used: (json['used'] as num?)?.toInt(),
  hardLimit: (json['hardLimit'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  warnLimit: (json['warnLimit'] as num?)?.toInt(),
  softLimit: (json['softLimit'] as num?)?.toInt(),
  description: json['description'] as String?,
  types: (json['types'] as List<dynamic>?)
      ?.map((e) => DataType.fromJson(e as String))
      .toList(),
  dataTypes: (json['dataTypes'] as List<dynamic>?)
      ?.map((e) => DataType.fromJson(e as String))
      .toList(),
);

Map<String, dynamic> _$QuotaToJson(Quota instance) => <String, dynamic>{
  'id': instance.id,
  'resourceType': _$ResourceTypeEnumMap[instance.resourceType]!,
  'used': ?instance.used,
  'hardLimit': ?instance.hardLimit,
  'limit': ?instance.limit,
  'scope': _$ScopeEnumMap[instance.scope]!,
  'name': instance.name,
  'dataTypes': ?instance.dataTypes,
  'types': ?instance.types,
  'warnLimit': ?instance.warnLimit,
  'softLimit': ?instance.softLimit,
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
