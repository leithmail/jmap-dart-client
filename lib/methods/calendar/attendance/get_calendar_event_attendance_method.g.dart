// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_calendar_event_attendance_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCalendarEventAttendanceMethod _$GetCalendarEventAttendanceMethodFromJson(
  Map<String, dynamic> json,
) =>
    GetCalendarEventAttendanceMethod(
        const AccountIdConverter().fromJson(json['accountId'] as String),
        (json['blobIds'] as List<dynamic>)
            .map((e) => const IdConverter().fromJson(e as String))
            .toList(),
      )
      ..ids = (json['ids'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toSet()
      ..referenceIds = json['#ids'] == null
          ? null
          : ResultReference.fromJson(json['#ids'] as Map<String, dynamic>)
      ..properties = const PropertiesConverter().fromJson(
        json['properties'] as List<String>?,
      )
      ..referenceProperties = json['#properties'] == null
          ? null
          : ResultReference.fromJson(
              json['#properties'] as Map<String, dynamic>,
            );

Map<String, dynamic> _$GetCalendarEventAttendanceMethodToJson(
  GetCalendarEventAttendanceMethod instance,
) => <String, dynamic>{
  'accountId': const AccountIdConverter().toJson(instance.accountId),
  'ids': ?instance.ids?.map(const IdConverter().toJson).toList(),
  '#ids': ?instance.referenceIds?.toJson(),
  'properties': ?const PropertiesConverter().toJson(instance.properties),
  '#properties': ?instance.referenceProperties?.toJson(),
  'blobIds': instance.blobIds.map(const IdConverter().toJson).toList(),
};
