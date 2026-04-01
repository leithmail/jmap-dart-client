// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailCapability _$MailCapabilityFromJson(Map<String, dynamic> json) =>
    MailCapability(
      maxMailboxesPerEmail: const UnsignedIntNullableConverter().fromJson(
        (json['maxMailboxesPerEmail'] as num?)?.toInt(),
      ),
      maxMailboxDepth: const UnsignedIntNullableConverter().fromJson(
        (json['maxMailboxDepth'] as num?)?.toInt(),
      ),
      maxSizeMailboxName: const UnsignedIntNullableConverter().fromJson(
        (json['maxSizeMailboxName'] as num?)?.toInt(),
      ),
      maxKeywordsPerEmail: const UnsignedIntNullableConverter().fromJson(
        (json['maxKeywordsPerEmail'] as num?)?.toInt(),
      ),
      maxSizeAttachmentsPerEmail: const UnsignedIntNullableConverter().fromJson(
        (json['maxSizeAttachmentsPerEmail'] as num?)?.toInt(),
      ),
      emailQuerySortOptions: (json['emailQuerySortOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet(),
      emailsListSortOptions: (json['emailsListSortOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet(),
      mayCreateTopLevelMailbox: json['mayCreateTopLevelMailbox'] as bool?,
    );

Map<String, dynamic> _$MailCapabilityToJson(MailCapability instance) =>
    <String, dynamic>{
      'maxMailboxesPerEmail': ?const UnsignedIntNullableConverter().toJson(
        instance.maxMailboxesPerEmail,
      ),
      'maxMailboxDepth': ?const UnsignedIntNullableConverter().toJson(
        instance.maxMailboxDepth,
      ),
      'maxSizeMailboxName': ?const UnsignedIntNullableConverter().toJson(
        instance.maxSizeMailboxName,
      ),
      'maxKeywordsPerEmail': ?const UnsignedIntNullableConverter().toJson(
        instance.maxKeywordsPerEmail,
      ),
      'maxSizeAttachmentsPerEmail': ?const UnsignedIntNullableConverter()
          .toJson(instance.maxSizeAttachmentsPerEmail),
      'emailQuerySortOptions': ?instance.emailQuerySortOptions?.toList(),
      'emailsListSortOptions': ?instance.emailsListSortOptions?.toList(),
      'mayCreateTopLevelMailbox': ?instance.mayCreateTopLevelMailbox,
    };
