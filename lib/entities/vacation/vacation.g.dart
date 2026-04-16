// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vacation _$VacationFromJson(Map<String, dynamic> json) => Vacation(
  id: json['id'] == null ? null : Id<Vacation>.fromJson(json['id'] as String),
  isEnabled: json['isEnabled'] as bool?,
  fromDate: json['fromDate'] == null
      ? null
      : UTCDate.fromJson(json['fromDate'] as String),
  toDate: json['toDate'] == null
      ? null
      : UTCDate.fromJson(json['toDate'] as String),
  subject: json['subject'] as String?,
  textBody: json['textBody'] as String?,
  htmlBody: json['htmlBody'] as String?,
);

Map<String, dynamic> _$VacationToJson(Vacation instance) => <String, dynamic>{
  'id': ?instance.id,
  'isEnabled': ?instance.isEnabled,
  'fromDate': ?instance.fromDate,
  'toDate': ?instance.toDate,
  'subject': ?instance.subject,
  'textBody': ?instance.textBody,
  'htmlBody': ?instance.htmlBody,
};
