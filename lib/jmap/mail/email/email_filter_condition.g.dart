// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_filter_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailFilterCondition _$EmailFilterConditionFromJson(
  Map<String, dynamic> json,
) => EmailFilterCondition(
  inMailbox: const MailboxIdNullableConverter().fromJson(
    json['inMailbox'] as String?,
  ),
  inMailboxOtherThan: (json['inMailboxOtherThan'] as List<dynamic>?)
      ?.map((e) => const MailboxIdNullableConverter().fromJson(e as String?))
      .toSet(),
  before: const UTCDateNullableConverter().fromJson(json['before'] as String?),
  after: const UTCDateNullableConverter().fromJson(json['after'] as String?),
  minSize: const UnsignedIntNullableConverter().fromJson(
    (json['minSize'] as num?)?.toInt(),
  ),
  maxSize: const UnsignedIntNullableConverter().fromJson(
    (json['maxSize'] as num?)?.toInt(),
  ),
  allInThreadHaveKeyword: json['allInThreadHaveKeyword'] as String?,
  someInThreadHaveKeyword: json['someInThreadHaveKeyword'] as String?,
  noneInThreadHaveKeyword: json['noneInThreadHaveKeyword'] as String?,
  hasKeyword: json['hasKeyword'] as String?,
  notKeyword: json['notKeyword'] as String?,
  hasAttachment: json['hasAttachment'] as bool?,
  text: json['text'] as String?,
  from: json['from'] as String?,
  to: json['to'] as String?,
  cc: json['cc'] as String?,
  bcc: json['bcc'] as String?,
  subject: json['subject'] as String?,
  body: json['body'] as String?,
  header: (json['header'] as List<dynamic>?)?.map((e) => e as String).toSet(),
);

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
