// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changes_mailbox_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangesMailboxResponse _$ChangesMailboxResponseFromJson(
  Map<String, dynamic> json,
) => ChangesMailboxResponse(
  const AccountIdConverter().fromJson(json['accountId'] as String),
  const StateConverter().fromJson(json['oldState'] as String),
  const StateConverter().fromJson(json['newState'] as String),
  json['hasMoreChanges'] as bool,
  (json['created'] as List<dynamic>)
      .map((e) => const IdConverter().fromJson(e as String))
      .toList(),
  (json['updated'] as List<dynamic>)
      .map((e) => const IdConverter().fromJson(e as String))
      .toList(),
  (json['destroyed'] as List<dynamic>)
      .map((e) => const IdConverter().fromJson(e as String))
      .toList(),
  updatedProperties: (json['updatedProperties'] as List<dynamic>?)
      ?.map((e) => MailboxProperty.fromJson(e as String))
      .toList(),
);
