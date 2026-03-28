// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VacationResponse _$VacationResponseFromJson(Map<String, dynamic> json) =>
    VacationResponse(
      id: const VacationIdNullableConverter().fromJson(json['id'] as String?),
      isEnabled: json['isEnabled'] as bool?,
      fromDate: const UTCDateNullableConverter().fromJson(
        json['fromDate'] as String?,
      ),
      toDate: const UTCDateNullableConverter().fromJson(
        json['toDate'] as String?,
      ),
      subject: json['subject'] as String?,
      textBody: json['textBody'] as String?,
      htmlBody: json['htmlBody'] as String?,
    );

Map<String, dynamic> _$VacationResponseToJson(VacationResponse instance) =>
    <String, dynamic>{
      'id': ?const VacationIdNullableConverter().toJson(instance.id),
      'isEnabled': ?instance.isEnabled,
      'fromDate': const UTCDateNullableConverter().toJson(instance.fromDate),
      'toDate': const UTCDateNullableConverter().toJson(instance.toDate),
      'subject': instance.subject,
      'textBody': instance.textBody,
      'htmlBody': instance.htmlBody,
    };
