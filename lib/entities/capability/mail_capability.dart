import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/capability_properties.dart';

import 'package:json_annotation/json_annotation.dart';

part 'mail_capability.g.dart';

@JsonSerializable(createToJson: false)
class MailCapability extends CapabilityProperties with EquatableMixin {
  final int? maxMailboxesPerEmail;
  final int? maxMailboxDepth;
  final int? maxSizeMailboxName;
  final int? maxKeywordsPerEmail;
  final int? maxSizeAttachmentsPerEmail;
  final List<String>? emailQuerySortOptions;
  final List<String>? emailsListSortOptions;
  final bool? mayCreateTopLevelMailbox;

  MailCapability({
    this.maxMailboxesPerEmail,
    this.maxMailboxDepth,
    this.maxSizeMailboxName,
    this.maxKeywordsPerEmail,
    this.maxSizeAttachmentsPerEmail,
    List<String>? emailQuerySortOptions,
    List<String>? emailsListSortOptions,
    this.mayCreateTopLevelMailbox,
  }) : emailQuerySortOptions = emailQuerySortOptions == null
           ? null
           : List.unmodifiable(emailQuerySortOptions),
       emailsListSortOptions = emailsListSortOptions == null
           ? null
           : List.unmodifiable(emailsListSortOptions);

  factory MailCapability.fromJson(Map<String, dynamic> json) =>
      _$MailCapabilityFromJson(json);

  @override
  List<Object?> get props => [
    maxMailboxesPerEmail,
    maxMailboxDepth,
    maxSizeMailboxName,
    maxKeywordsPerEmail,
    maxSizeAttachmentsPerEmail,
    emailQuerySortOptions,
    emailsListSortOptions,
    mayCreateTopLevelMailbox,
  ];
}
