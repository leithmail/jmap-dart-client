import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox_rights.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mailbox.g.dart';

@JsonSerializable(includeIfNull: false)
class Mailbox with EquatableMixin {
  final MailboxId? id;
  final String? name;
  final MailboxId? parentId;
  final MailboxRole? role;
  final int? sortOrder;
  final int? totalEmails;
  final int? unreadEmails;
  final int? totalThreads;
  final int? unreadThreads;
  final MailboxRights? myRights;
  final bool? isSubscribed;

  Mailbox({
    this.id,
    this.name,
    this.parentId,
    this.role,
    this.sortOrder,
    this.totalEmails,
    this.unreadEmails,
    this.totalThreads,
    this.unreadThreads,
    this.myRights,
    this.isSubscribed,
  });

  factory Mailbox.fromJson(Map<String, dynamic> json) =>
      _$MailboxFromJson(json);

  Map<String, dynamic> toJson() => _$MailboxToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    parentId,
    role,
    sortOrder,
    totalEmails,
    unreadEmails,
    totalThreads,
    unreadThreads,
    myRights,
    isSubscribed,
  ];
}

typedef MailboxId = Id<Mailbox>;
typedef MailboxCreationId = CreationId<Mailbox>;

class MailboxRole with EquatableMixin {
  final String value;

  // JMAP spec states that mailboxes role must be one of IMAP Mailbox Name Attributes
  // https://www.iana.org/assignments/imap-mailbox-name-attributes/imap-mailbox-name-attributes.xhtml
  // According to this link, the attribute name for Junk/Spam folder is `junk`
  // However, some servers and client use `spam` instead for historical reasons
  // To allow compatibility, convert `spam` to `junk`.
  // This should be removed some day, when every server and client has been fixed
  MailboxRole(value) : value = value == "spam" ? "junk" : value;

  String toJson() => value;
  factory MailboxRole.fromJson(String value) => MailboxRole(value);

  @override
  List<Object?> get props => [value];
}
