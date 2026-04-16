// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailSubmission _$EmailSubmissionFromJson(Map<String, dynamic> json) =>
    EmailSubmission(
      id: json['id'] == null
          ? null
          : Id<EmailSubmission>.fromJson(json['id'] as String),
      identityId: json['identityId'] == null
          ? null
          : Id<Identity>.fromJson(json['identityId'] as String),
      emailId: json['emailId'] == null
          ? null
          : Id<Email>.fromJson(json['emailId'] as String),
      threadId: json['threadId'] == null
          ? null
          : Id<Thread>.fromJson(json['threadId'] as String),
      envelope: json['envelope'] == null
          ? null
          : Envelope.fromJson(json['envelope'] as Map<String, dynamic>),
      sendAt: json['sendAt'] == null
          ? null
          : UTCDate.fromJson(json['sendAt'] as String),
      undoStatus: json['undoStatus'] == null
          ? null
          : UndoStatus.fromJson(json['undoStatus'] as String),
      deliveryStatus: (json['deliveryStatus'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, DeliveryStatus.fromJson(e as Map<String, dynamic>)),
      ),
      dsnBlobIds: (json['dsnBlobIds'] as List<dynamic>?)
          ?.map((e) => BlobId.fromJson(e as String))
          .toList(),
      mdnBlobIds: (json['mdnBlobIds'] as List<dynamic>?)
          ?.map((e) => BlobId.fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$EmailSubmissionToJson(EmailSubmission instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'identityId': ?instance.identityId,
      'emailId': ?instance.emailId,
      'threadId': ?instance.threadId,
      'envelope': ?instance.envelope,
      'sendAt': ?instance.sendAt,
      'undoStatus': ?instance.undoStatus,
      'deliveryStatus': ?instance.deliveryStatus,
      'dsnBlobIds': ?instance.dsnBlobIds,
      'mdnBlobIds': ?instance.mdnBlobIds,
    };
