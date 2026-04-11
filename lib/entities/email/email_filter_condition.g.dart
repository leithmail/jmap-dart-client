// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_filter_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$EmailFilterConditionToJson(
  EmailFilterCondition instance,
) => <String, dynamic>{
  'inMailbox': ?const MailboxIdNullableConverter().toJson(instance.inMailbox),
  'inMailboxOtherThan': ?instance.inMailboxOtherThan
      ?.map(const MailboxIdNullableConverter().toJson)
      .toList(),
  'before': ?const UTCDateNullableConverter().toJson(instance.before),
  'after': ?const UTCDateNullableConverter().toJson(instance.after),
  'minSize': ?const UnsignedIntNullableConverter().toJson(instance.minSize),
  'maxSize': ?const UnsignedIntNullableConverter().toJson(instance.maxSize),
  'allInThreadHaveKeyword': ?instance.allInThreadHaveKeyword,
  'someInThreadHaveKeyword': ?instance.someInThreadHaveKeyword,
  'noneInThreadHaveKeyword': ?instance.noneInThreadHaveKeyword,
  'hasKeyword': ?instance.hasKeyword,
  'notKeyword': ?instance.notKeyword,
  'hasAttachment': ?instance.hasAttachment,
  'text': ?instance.text,
  'from': ?instance.from,
  'to': ?instance.to,
  'cc': ?instance.cc,
  'bcc': ?instance.bcc,
  'subject': ?instance.subject,
  'body': ?instance.body,
  'header': ?instance.header?.toList(),
};
