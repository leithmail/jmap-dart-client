import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/capability_properties.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/src/converters/unsigned_int_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mail_capability.g.dart';

@UnsignedIntNullableConverter()
@JsonSerializable(createToJson: false)
class MailCapability extends CapabilityProperties with EquatableMixin {
  final UnsignedInt? maxMailboxesPerEmail;
  final UnsignedInt? maxMailboxDepth;
  final UnsignedInt? maxSizeMailboxName;
  final UnsignedInt? maxKeywordsPerEmail;
  final UnsignedInt? maxSizeAttachmentsPerEmail;
  final Set<String>? emailQuerySortOptions;
  final Set<String>? emailsListSortOptions;
  final bool? mayCreateTopLevelMailbox;

  MailCapability({
    this.maxMailboxesPerEmail,
    this.maxMailboxDepth,
    this.maxSizeMailboxName,
    this.maxKeywordsPerEmail,
    this.maxSizeAttachmentsPerEmail,
    Set<String>? emailQuerySortOptions,
    Set<String>? emailsListSortOptions,
    this.mayCreateTopLevelMailbox,
  }) : emailQuerySortOptions = emailQuerySortOptions == null
           ? null
           : Set.unmodifiable(emailQuerySortOptions),
       emailsListSortOptions = emailsListSortOptions == null
           ? null
           : Set.unmodifiable(emailsListSortOptions);

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
