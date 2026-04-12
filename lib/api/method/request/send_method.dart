import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/mdn/mdn.dart';

abstract class SendMethod<
  R extends MethodResponse,
  Q extends ResultReference,
  T
>
    extends MethodWithAccountId<R, Q> {
  final _send = MapArgumentSlot<Id, MDN>(
    'send',
    (k) => k.value,
    (v) => v.toJson(),
  );

  SendMethod({required super.accountId, required Argument<Map<Id, MDN>> send}) {
    _send.set(send);
  }

  @override
  get slots => [...super.slots, _send];
}
