// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_identity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetIdentityResponse _$GetIdentityResponseFromJson(Map<String, dynamic> json) =>
    GetIdentityResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['state'] as String),
      (json['list'] as List<dynamic>)
          .map((e) => Identity.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notFound'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toList(),
    );
