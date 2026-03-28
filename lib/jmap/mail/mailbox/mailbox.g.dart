// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mailbox _$MailboxFromJson(Map<String, dynamic> json) => Mailbox(
  id: const MailboxIdNullableConverter().fromJson(json['id'] as String?),
  name: const MailboxNameConverter().fromJson(json['name'] as String?),
  parentId: const MailboxIdNullableConverter().fromJson(
    json['parentId'] as String?,
  ),
  role: const RoleConverter().fromJson(json['role'] as String?),
  sortOrder: const SortOrderConverter().fromJson(
    (json['sortOrder'] as num?)?.toInt(),
  ),
  totalEmails: const TotalEmailConverter().fromJson(
    (json['totalEmails'] as num?)?.toInt(),
  ),
  unreadEmails: const UnreadEmailsConverter().fromJson(
    (json['unreadEmails'] as num?)?.toInt(),
  ),
  totalThreads: const TotalThreadsConverter().fromJson(
    (json['totalThreads'] as num?)?.toInt(),
  ),
  unreadThreads: const UnreadThreadsConverter().fromJson(
    (json['unreadThreads'] as num?)?.toInt(),
  ),
  myRights: json['myRights'] == null
      ? null
      : MailboxRights.fromJson(json['myRights'] as Map<String, dynamic>),
  isSubscribed: const IsSubscribedConverter().fromJson(
    json['isSubscribed'] as bool?,
  ),
  namespace: const NamespaceNullableConverter().fromJson(
    json['namespace'] as String?,
  ),
  rights: (json['rights'] as Map<String, dynamic>?)?.map(
    (k, e) =>
        MapEntry(k, (e as List<dynamic>?)?.map((e) => e as String).toList()),
  ),
);

Map<String, dynamic> _$MailboxToJson(Mailbox instance) => <String, dynamic>{
  'id': ?const MailboxIdNullableConverter().toJson(instance.id),
  'name': ?const MailboxNameConverter().toJson(instance.name),
  'parentId': ?const MailboxIdNullableConverter().toJson(instance.parentId),
  'role': ?const RoleConverter().toJson(instance.role),
  'sortOrder': ?const SortOrderConverter().toJson(instance.sortOrder),
  'totalEmails': ?const TotalEmailConverter().toJson(instance.totalEmails),
  'unreadEmails': ?const UnreadEmailsConverter().toJson(instance.unreadEmails),
  'totalThreads': ?const TotalThreadsConverter().toJson(instance.totalThreads),
  'unreadThreads': ?const UnreadThreadsConverter().toJson(
    instance.unreadThreads,
  ),
  'myRights': ?instance.myRights,
  'isSubscribed': ?const IsSubscribedConverter().toJson(instance.isSubscribed),
  'namespace': ?const NamespaceNullableConverter().toJson(instance.namespace),
  'rights': ?instance.rights,
};
