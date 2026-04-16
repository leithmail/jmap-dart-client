import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mailbox_rights.g.dart';

@JsonSerializable()
class MailboxRights with EquatableMixin {
  final bool mayReadItems;
  final bool mayAddItems;
  final bool mayRemoveItems;
  final bool maySetSeen;
  final bool maySetKeywords;
  final bool mayCreateChild;
  final bool mayRename;
  final bool mayDelete;
  final bool maySubmit;

  MailboxRights({
    required this.mayReadItems,
    required this.mayAddItems,
    required this.mayRemoveItems,
    required this.maySetSeen,
    required this.maySetKeywords,
    required this.mayCreateChild,
    required this.mayRename,
    required this.mayDelete,
    required this.maySubmit,
  });

  factory MailboxRights.fromJson(Map<String, dynamic> json) {
    return _$MailboxRightsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MailboxRightsToJson(this);

  @override
  List<Object?> get props => [
    mayReadItems,
    mayAddItems,
    mayRemoveItems,
    maySetSeen,
    maySetKeywords,
    mayCreateChild,
    mayRename,
    mayDelete,
    maySubmit,
  ];
}
