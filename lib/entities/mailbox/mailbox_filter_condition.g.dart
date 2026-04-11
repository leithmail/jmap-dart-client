// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox_filter_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$MailboxFilterConditionToJson(
  MailboxFilterCondition instance,
) => <String, dynamic>{
  'role': ?const RoleConverter().toJson(instance.role),
  'name': ?const MailboxNameConverter().toJson(instance.name),
  'hasAnyRole': ?instance.hasAnyRole,
  'isSubscribed': ?instance.isSubscribed,
  'parentId': ?const MailboxIdNullableConverter().toJson(instance.parentId),
};
