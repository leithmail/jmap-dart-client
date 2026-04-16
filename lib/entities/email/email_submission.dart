import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/utc_date.dart';
import 'package:jmap_dart_client/entities/email/delivery_status.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/entities/email/envelope.dart';
import 'package:jmap_dart_client/entities/identity/identity.dart';
import 'package:jmap_dart_client/entities/thread/thread.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_submission.g.dart';

@JsonSerializable(includeIfNull: false)
class EmailSubmission with EquatableMixin {
  final EmailSubmissionId? id;
  final IdentityId? identityId;
  final EmailId? emailId;
  final ThreadId? threadId;
  final Envelope? envelope;
  final UTCDate? sendAt;
  final UndoStatus? undoStatus;
  final Map<String, DeliveryStatus>? deliveryStatus;
  final List<BlobId>? dsnBlobIds;
  final List<BlobId>? mdnBlobIds;

  EmailSubmission({
    required this.id,
    required this.identityId,
    required this.emailId,
    required this.threadId,
    required this.envelope,
    required this.sendAt,
    required this.undoStatus,
    required this.deliveryStatus,
    required this.dsnBlobIds,
    required this.mdnBlobIds,
  });

  factory EmailSubmission.fromJson(Map<String, dynamic> json) =>
      _$EmailSubmissionFromJson(json);

  Map<String, dynamic> toJson() => _$EmailSubmissionToJson(this);

  @override
  List<Object?> get props => [
    id,
    identityId,
    emailId,
    threadId,
    envelope,
    sendAt,
    undoStatus,
    deliveryStatus,
    dsnBlobIds,
    mdnBlobIds,
  ];
}

typedef EmailSubmissionId = Id<EmailSubmission>;

class UndoStatus with EquatableMixin {
  static final UndoStatus pendingStatus = UndoStatus('pending');
  static final UndoStatus finalStatus = UndoStatus('final');
  static final UndoStatus canceledStatus = UndoStatus('canceled');

  final String value;

  UndoStatus(this.value);

  String toJson() => value;
  factory UndoStatus.fromJson(String value) => UndoStatus(value);

  @override
  List<Object?> get props => [value];
}
