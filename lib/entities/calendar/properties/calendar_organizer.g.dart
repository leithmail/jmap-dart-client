// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_organizer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarOrganizer _$CalendarOrganizerFromJson(Map<String, dynamic> json) =>
    CalendarOrganizer(
      name: json['name'] as String?,
      mailto: const MailAddressNullableConverter().fromJson(
        json['mailto'] as String?,
      ),
    );

Map<String, dynamic> _$CalendarOrganizerToJson(CalendarOrganizer instance) =>
    <String, dynamic>{
      'name': ?instance.name,
      'mailto': ?const MailAddressNullableConverter().toJson(instance.mailto),
    };
