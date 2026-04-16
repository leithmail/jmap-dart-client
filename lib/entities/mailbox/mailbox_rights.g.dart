// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox_rights.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailboxRights _$MailboxRightsFromJson(Map<String, dynamic> json) =>
    MailboxRights(
      mayReadItems: json['mayReadItems'] as bool,
      mayAddItems: json['mayAddItems'] as bool,
      mayRemoveItems: json['mayRemoveItems'] as bool,
      maySetSeen: json['maySetSeen'] as bool,
      maySetKeywords: json['maySetKeywords'] as bool,
      mayCreateChild: json['mayCreateChild'] as bool,
      mayRename: json['mayRename'] as bool,
      mayDelete: json['mayDelete'] as bool,
      maySubmit: json['maySubmit'] as bool,
    );

Map<String, dynamic> _$MailboxRightsToJson(MailboxRights instance) =>
    <String, dynamic>{
      'mayReadItems': instance.mayReadItems,
      'mayAddItems': instance.mayAddItems,
      'mayRemoveItems': instance.mayRemoveItems,
      'maySetSeen': instance.maySetSeen,
      'maySetKeywords': instance.maySetKeywords,
      'mayCreateChild': instance.mayCreateChild,
      'mayRename': instance.mayRename,
      'mayDelete': instance.mayDelete,
      'maySubmit': instance.maySubmit,
    };
