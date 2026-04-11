import 'package:jmap_dart_client/api/method/argument/filter/filter_condition.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/src/converters/mailbox_id_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/mailbox_name_converter.dart';
import 'package:jmap_dart_client/src/converters/role_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mailbox_filter_condition.g.dart';

@RoleConverter()
@MailboxNameConverter()
@MailboxIdNullableConverter()
@JsonSerializable(createFactory: false)
class MailboxFilterCondition extends FilterCondition {
  @JsonKey(includeIfNull: false)
  final Role? role;
  @JsonKey(includeIfNull: false)
  final MailboxName? name;
  @JsonKey(includeIfNull: false)
  final bool? hasAnyRole;
  @JsonKey(includeIfNull: false)
  final bool? isSubscribed;
  @JsonKey(includeIfNull: false)
  final MailboxId? parentId;

  MailboxFilterCondition({
    this.role,
    this.parentId,
    this.name,
    this.hasAnyRole,
    this.isSubscribed,
  });

  @override
  Map<String, dynamic> toJson() => _$MailboxFilterConditionToJson(this);
}
