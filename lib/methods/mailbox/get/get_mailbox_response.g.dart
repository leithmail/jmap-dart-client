// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_mailbox_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMailboxResponse _$GetMailboxResponseFromJson(Map<String, dynamic> json) =>
    GetMailboxResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['state'] as String),
      (json['list'] as List<dynamic>)
          .map((e) => Mailbox.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notFound'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toList(),
    );
