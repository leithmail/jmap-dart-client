// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_quota_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetQuotaResponse _$GetQuotaResponseFromJson(Map<String, dynamic> json) =>
    GetQuotaResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['state'] as String),
      (json['list'] as List<dynamic>)
          .map((e) => Quota.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notFound'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toList(),
    );
