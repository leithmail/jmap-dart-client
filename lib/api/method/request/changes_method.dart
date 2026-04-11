import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';

abstract class ChangesMethod<R extends MethodResponse>
    extends MethodRequiringAccountId<R> {
  final sinceState = ArgumentSlot<State>('sinceState', (v) => v.value);
  final maxChanges = ArgumentSlot<UnsignedInt?>("maxChanges", (v) => v?.value);

  ChangesMethod(
    AccountId accountId,
    State sinceState, {
    UnsignedInt? maxChanges,
  }) : super(accountId) {
    this.maxChanges.set(maxChanges);
    this.sinceState.set(sinceState);
  }

  @override
  List<ArgumentSlot<dynamic>> get slots => [
    ...super.slots,
    sinceState,
    maxChanges,
  ];
}
