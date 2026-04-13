// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_mailbox_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryMailboxResponse _$QueryMailboxResponseFromJson(
  Map<String, dynamic> json,
) => QueryMailboxResponse(
  const AccountIdConverter().fromJson(json['accountId'] as String),
  const StateConverter().fromJson(json['queryState'] as String),
  json['canCalculateChanges'] as bool,
  (json['position'] as num).toInt(),
  (json['ids'] as List<dynamic>)
      .map((e) => const IdConverter().fromJson(e as String))
      .toList(),
  (json['total'] as num?)?.toInt(),
  (json['limit'] as num?)?.toInt(),
);
