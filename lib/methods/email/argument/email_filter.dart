import 'package:jmap_dart_client/api/method/argument/filter.dart';
import 'package:jmap_dart_client/entities/core/utc_date.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_filter.g.dart';

typedef EmailFilter = Filter<_EmailFilterCondition>;

class EmailFilterOperator extends FilterOperatorBase<_EmailFilterCondition> {
  EmailFilterOperator(super.operator, super.conditions);
}

class EmailFilterCondition extends FilterConditionBase<_EmailFilterCondition> {
  EmailFilterCondition({
    MailboxId? inMailbox,
    List<MailboxId?>? inMailboxOtherThan,
    UTCDate? before,
    UTCDate? after,
    int? minSize,
    int? maxSize,
    String? allInThreadHaveKeyword,
    String? someInThreadHaveKeyword,
    String? noneInThreadHaveKeyword,
    String? hasKeyword,
    String? notKeyword,
    bool? hasAttachment,
    String? text,
    String? from,
    String? to,
    String? cc,
    String? bcc,
    String? subject,
    String? body,
    List<String>? header,
  }) : super(
         _EmailFilterCondition(
           inMailbox: inMailbox,
           inMailboxOtherThan: inMailboxOtherThan,
           before: before,
           after: after,
           minSize: minSize,
           maxSize: maxSize,
           allInThreadHaveKeyword: allInThreadHaveKeyword,
           someInThreadHaveKeyword: someInThreadHaveKeyword,
           noneInThreadHaveKeyword: noneInThreadHaveKeyword,
           hasKeyword: hasKeyword,
           notKeyword: notKeyword,
           hasAttachment: hasAttachment,
           text: text,
           from: from,
           to: to,
           cc: cc,
           bcc: bcc,
           subject: subject,
           body: body,
           header: header,
         ),
       );
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class _EmailFilterCondition extends FilterCondition {
  final MailboxId? inMailbox;
  final List<MailboxId?>? inMailboxOtherThan;
  final UTCDate? before;
  final UTCDate? after;
  final int? minSize;
  final int? maxSize;
  final String? allInThreadHaveKeyword;
  final String? someInThreadHaveKeyword;
  final String? noneInThreadHaveKeyword;
  final String? hasKeyword;
  final String? notKeyword;
  final bool? hasAttachment;
  final String? text;
  final String? from;
  final String? to;
  final String? cc;
  final String? bcc;
  final String? subject;
  final String? body;
  final List<String>? header;

  _EmailFilterCondition({
    this.inMailbox,
    this.inMailboxOtherThan,
    this.before,
    this.after,
    this.minSize,
    this.maxSize,
    this.allInThreadHaveKeyword,
    this.someInThreadHaveKeyword,
    this.noneInThreadHaveKeyword,
    this.hasKeyword,
    this.notKeyword,
    this.hasAttachment,
    this.text,
    this.from,
    this.to,
    this.cc,
    this.bcc,
    this.subject,
    this.body,
    this.header,
  });

  @override
  Map<String, dynamic> toJson() => _$EmailFilterConditionToJson(this);
}
