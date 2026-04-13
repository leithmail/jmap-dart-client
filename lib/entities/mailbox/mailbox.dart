import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox_rights.dart';
import 'package:jmap_dart_client/entities/mailbox/namespace.dart';
import 'package:jmap_dart_client/src/converters/is_subscribed_converter.dart';
import 'package:jmap_dart_client/src/converters/mailbox_name_converter.dart';
import 'package:jmap_dart_client/src/converters/namespace_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/role_converter.dart';
import 'package:jmap_dart_client/src/converters/sort_order_converter.dart';
import 'package:jmap_dart_client/src/converters/total_email_converter.dart';
import 'package:jmap_dart_client/src/converters/total_threads_converter.dart';
import 'package:jmap_dart_client/src/converters/unread_emails_converter.dart';
import 'package:jmap_dart_client/src/converters/unread_threads_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mailbox.g.dart';

@NamespaceNullableConverter()
@IsSubscribedConverter()
@UnreadThreadsConverter()
@UnreadEmailsConverter()
@TotalThreadsConverter()
@TotalEmailConverter()
@SortOrderConverter()
@RoleConverter()
@MailboxNameConverter()
@JsonSerializable(includeIfNull: false)
class Mailbox with EquatableMixin {
  final MailboxId? id;
  final MailboxName? name;
  final MailboxId? parentId;
  final Role? role;
  final SortOrder? sortOrder;
  final TotalEmails? totalEmails;
  final UnreadEmails? unreadEmails;
  final TotalThreads? totalThreads;
  final UnreadThreads? unreadThreads;
  final MailboxRights? myRights;
  final IsSubscribed? isSubscribed;
  final Namespace? namespace;
  final Map<String, List<String>?>? rights;

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
    this.namespace,
    this.rights,
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
    namespace,
    rights,
  ];
}

class MailboxId extends Id {
  const MailboxId(super.value);
  factory MailboxId.fromJson(String json) => MailboxId(json);
}

class MailboxName with EquatableMixin {
  final String name;

  MailboxName(this.name);

  @override
  List<Object?> get props => [name];
}

class Role with EquatableMixin {
  final String value;

  // JMAP spec states that mailboxes role must be one of IMAP Mailbox Name Attributes
  // https://www.iana.org/assignments/imap-mailbox-name-attributes/imap-mailbox-name-attributes.xhtml
  // According to this link, the attribute name for Junk/Spam folder is `junk`
  // However, some servers and client use `spam` instead for historical reasons
  // To allow compatibility, convert `spam` to `junk`.
  // This should be removed some day, when every server and client has been fixed
  Role(value) : value = value == "spam" ? "junk" : value;

  @override
  List<Object?> get props => [value];
}

class SortOrder with EquatableMixin {
  late final int value;

  SortOrder({int sortValue = 0}) {
    value = sortValue;
  }

  @override
  List<Object?> get props => [value];
}

class TotalEmails with EquatableMixin {
  final int value;

  TotalEmails(this.value);

  @override
  List<Object?> get props => [value];
}

class UnreadEmails with EquatableMixin {
  final int value;

  UnreadEmails(this.value);

  @override
  List<Object?> get props => [value];
}

class TotalThreads with EquatableMixin {
  final int value;

  TotalThreads(this.value);

  @override
  List<Object?> get props => [value];
}

class UnreadThreads with EquatableMixin {
  final int value;

  UnreadThreads(this.value);

  @override
  List<Object?> get props => [value];
}

class IsSubscribed with EquatableMixin {
  final bool value;

  IsSubscribed(this.value);

  @override
  List<Object?> get props => [value];
}
