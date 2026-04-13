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
          .toList(),
      emailsListSortOptions: (json['emailsListSortOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      mayCreateTopLevelMailbox: json['mayCreateTopLevelMailbox'] as bool?,
    );
