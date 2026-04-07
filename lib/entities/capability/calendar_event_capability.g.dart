// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEventCapability _$CalendarEventCapabilityFromJson(
  Map<String, dynamic> json,
) => CalendarEventCapability(
  replySupportedLanguage: (json['replySupportedLanguage'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  supportFreeBusyQuery: json['supportFreeBusyQuery'] as bool?,
  counterSupport: json['counterSupport'] as bool?,
);
