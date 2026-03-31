// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox_filter_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailboxFilterCondition _$MailboxFilterConditionFromJson(
  Map<String, dynamic> json,
) => MailboxFilterCondition(
  role: const RoleConverter().fromJson(json['role'] as String?),
  parentId: const MailboxIdNullableConverter().fromJson(
    json['parentId'] as String?,
  ),
  name: const MailboxNameConverter().fromJson(json['name'] as String?),
  hasAnyRole: json['hasAnyRole'] as bool?,
  isSubscribed: json['isSubscribed'] as bool?,
);

Map<String, dynamic> _$MailboxFilterConditionToJson(
  MailboxFilterCondition instance,
) => <String, dynamic>{
  'role': ?const RoleConverter().toJson(instance.role),
  'name': ?const MailboxNameConverter().toJson(instance.name),
  'hasAnyRole': ?instance.hasAnyRole,
  'isSubscribed': ?instance.isSubscribed,
  'parentId': ?const MailboxIdNullableConverter().toJson(instance.parentId),
};
