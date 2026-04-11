import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/clear_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/methods/mailbox/clear/clear_mailbox_response.dart';
import 'package:jmap_dart_client/src/converters/mailbox_id_converter.dart';

class ClearMailboxMethod extends ClearMethod<ClearMailboxResponse> {
  final mailboxId = ArgumentSlot<MailboxId>(
    'mailboxId',
    (v) => const MailboxIdConverter().toJson(v),
  );

  ClearMailboxMethod(AccountId accountId, MailboxId mailboxId)
    : super(accountId) {
    this.mailboxId.set(mailboxId);
  }

  @override
  MethodName methodName() => MethodName('Mailbox/clear');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapMailboxClear,
  };

  @override
  get slots => [...super.slots, mailboxId];

  @override
  ClearMailboxResponse responseFromJson(Map<String, dynamic> json) {
    return ClearMailboxResponse.fromJson(json);
  }
}
