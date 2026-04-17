import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/methods/mailbox/set_mailbox_response.dart';

class SetMailboxMethod
    extends SetMethod<Mailbox, SetMailboxResponse, ResultReference>
    with EmptyResultReferences {
  final onDestroyRemoveEmails = PrimitiveSlot<bool>('onDestroyRemoveEmails');

  SetMailboxMethod({required super.accountId});

  @override
  MethodName get methodName => MethodName('Mailbox/set');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapMail,
  ];

  @override
  SetMailboxResponse responseFromJson(Map<String, dynamic> json) {
    return SetMailboxResponse.fromJson(json);
  }

  @override
  Object? typeToJson(Mailbox v) => v.toJson();

  @override
  get slots => [...super.slots, onDestroyRemoveEmails];
}
