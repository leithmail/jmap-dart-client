// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailCapability _$MailCapabilityFromJson(Map<String, dynamic> json) =>
    MailCapability(
      maxMailboxesPerEmail: (json['maxMailboxesPerEmail'] as num?)?.toInt(),
      maxMailboxDepth: (json['maxMailboxDepth'] as num?)?.toInt(),
      maxSizeMailboxName: (json['maxSizeMailboxName'] as num?)?.toInt(),
      maxKeywordsPerEmail: (json['maxKeywordsPerEmail'] as num?)?.toInt(),
      maxSizeAttachmentsPerEmail: (json['maxSizeAttachmentsPerEmail'] as num?)
          ?.toInt(),
      emailQuerySortOptions: (json['emailQuerySortOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      emailsListSortOptions: (json['emailsListSortOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      mayCreateTopLevelMailbox: json['mayCreateTopLevelMailbox'] as bool?,
    );
