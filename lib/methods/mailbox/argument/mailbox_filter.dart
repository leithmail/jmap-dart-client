import 'package:jmap_dart_client/api/method/argument/filter.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mailbox_filter.g.dart';

typedef MailboxFilter = Filter<_MailboxFilterCondition>;

class MailboxFilterOperator
    extends FilterOperatorBase<_MailboxFilterCondition> {
  MailboxFilterOperator(super.operator, super.conditions);
}

class MailboxFilterCondition
    extends FilterConditionBase<_MailboxFilterCondition> {
  MailboxFilterCondition({
    MailboxRole? role,
    String? name,
    bool? hasAnyRole,
    bool? isSubscribed,
    MailboxId? parentId,
  }) : super(
         _MailboxFilterCondition(
           role: role,
           name: name,
           hasAnyRole: hasAnyRole,
           isSubscribed: isSubscribed,
           parentId: parentId,
         ),
       );
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class _MailboxFilterCondition extends FilterCondition {
  final MailboxRole? role;
  final String? name;
  final bool? hasAnyRole;
  final bool? isSubscribed;
  final MailboxId? parentId;

  _MailboxFilterCondition({
    this.role,
    this.parentId,
    this.name,
    this.hasAnyRole,
    this.isSubscribed,
  });

  @override
  Map<String, dynamic> toJson() => _$MailboxFilterConditionToJson(this);
}
