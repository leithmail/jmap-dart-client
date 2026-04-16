// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mailbox _$MailboxFromJson(Map<String, dynamic> json) => Mailbox(
  id: json['id'] == null ? null : Id<Mailbox>.fromJson(json['id'] as String),
  name: json['name'] as String?,
  parentId: json['parentId'] == null
      ? null
      : Id<Mailbox>.fromJson(json['parentId'] as String),
  role: json['role'] == null
      ? null
      : MailboxRole.fromJson(json['role'] as String),
  sortOrder: (json['sortOrder'] as num?)?.toInt(),
  totalEmails: (json['totalEmails'] as num?)?.toInt(),
  unreadEmails: (json['unreadEmails'] as num?)?.toInt(),
  totalThreads: (json['totalThreads'] as num?)?.toInt(),
  unreadThreads: (json['unreadThreads'] as num?)?.toInt(),
  myRights: json['myRights'] == null
      ? null
      : MailboxRights.fromJson(json['myRights'] as Map<String, dynamic>),
  isSubscribed: json['isSubscribed'] as bool?,
);

Map<String, dynamic> _$MailboxToJson(Mailbox instance) => <String, dynamic>{
  'id': ?instance.id,
  'name': ?instance.name,
  'parentId': ?instance.parentId,
  'role': ?instance.role,
  'sortOrder': ?instance.sortOrder,
  'totalEmails': ?instance.totalEmails,
  'unreadEmails': ?instance.unreadEmails,
  'totalThreads': ?instance.totalThreads,
  'unreadThreads': ?instance.unreadThreads,
  'myRights': ?instance.myRights,
  'isSubscribed': ?instance.isSubscribed,
};
