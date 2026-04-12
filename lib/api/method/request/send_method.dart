import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/mdn/mdn.dart';

abstract class SendMethod<R extends MethodResponse, T>
    extends MethodRequiringAccountId<R> {
  final send = MapArgumentSlot<Id, MDN>(
    'send',
    (k) => k.value,
    (v) => v.toJson(),
  );

  SendMethod(AccountId accountId, Map<Id, MDN> send) : super(accountId) {
    this.send.set(send);
  }
  @override
  get slots => [...super.slots, send];
}
