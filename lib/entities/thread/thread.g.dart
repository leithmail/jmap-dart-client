// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thread _$ThreadFromJson(Map<String, dynamic> json) => Thread(
  id: Id<Thread>.fromJson(json['id'] as String),
  emailIds: (json['emailIds'] as List<dynamic>)
      .map((e) => Id<Email>.fromJson(e as String))
      .toList(),
);

Map<String, dynamic> _$ThreadToJson(Thread instance) => <String, dynamic>{
  'id': instance.id,
  'emailIds': instance.emailIds,
};
