// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_vacation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVacationResponse _$GetVacationResponseFromJson(Map<String, dynamic> json) =>
    GetVacationResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['state'] as String),
      (json['list'] as List<dynamic>)
          .map((e) => VacationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notFound'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toList(),
    );
