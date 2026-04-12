import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/clear_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/methods/mailbox/clear/clear_mailbox_response.dart';

class ClearMailboxMethod
    extends ClearMethod<ClearMailboxResponse, ResultReference>
    with EmptyResultReferences {
  final mailboxId = ArgumentSlot<MailboxId>('mailboxId', (v) => v.id.value);

  ClearMailboxMethod({required super.accountId});

  @override
  MethodName get methodName => MethodName('Mailbox/clear');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapMailboxClear,
  ];

  @override
  get slots => [...super.slots, mailboxId];

  @override
  ClearMailboxResponse responseFromJson(Map<String, dynamic> json) {
    return ClearMailboxResponse.fromJson(json);
  }
}
