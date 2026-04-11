import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/methods/mailbox/set/set_mailbox_response.dart';

class SetMailboxMethod extends SetMethod<SetMailboxResponse, Mailbox>
    with OptionalOnDestroyRemoveEmails {
  SetMailboxMethod(AccountId accountId) : super(accountId);

  @override
  MethodName methodName() => MethodName('Mailbox/set');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapCore,
  };

  @override
  SetMailboxResponse responseFromJson(Map<String, dynamic> json) {
    return SetMailboxResponse.fromJson(json);
  }

  @override
  Object? typeToJson(Mailbox v) => v.toJson();
}

mixin OptionalOnDestroyRemoveEmails<
  R extends MethodResponse,
  F extends ResultReference
>
    on Method<R, F> {
  final onDestroyRemoveEmails = ArgumentSlot<bool?>(
    'onDestroyRemoveEmails',
    (v) => v,
  );

  void addOnDestroyRemoveEmails(bool value) {
    onDestroyRemoveEmails.set(value);
  }

  @override
  get slots => [...super.slots, onDestroyRemoveEmails];
}
