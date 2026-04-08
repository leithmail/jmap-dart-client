import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/clear_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/methods/mailbox/clear/clear_mailbox_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/mailbox_id_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'clear_mailbox_method.g.dart';

@AccountIdConverter()
@MailboxIdConverter()
@JsonSerializable()
class ClearMailboxMethod extends ClearMethod<ClearMailboxResponse> {
  final MailboxId mailboxId;

  ClearMailboxMethod(AccountId accountId, this.mailboxId) : super(accountId);

  @override
  MethodName get methodName => MethodName('Mailbox/clear');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapMailboxClear,
  };

  Set<CapabilityIdentifier> get requiredCapabilitiesSupportTeamMailboxes => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapTeamMailboxes,
    CapabilityIdentifier.jmapMailboxClear,
  };

  factory ClearMailboxMethod.fromJson(Map<String, dynamic> json) =>
      _$ClearMailboxMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClearMailboxMethodToJson(this);

  @override
  ClearMailboxResponse responseFromJson(Map<String, dynamic> json) {
    return ClearMailboxResponse.fromJson(json);
  }
}
