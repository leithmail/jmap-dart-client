import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/state.dart';

abstract class ChangesMethod<
  R extends MethodResponse,
  Q extends ResultReference
>
    extends MethodWithAccountId<R, Q> {
  final _sinceState = ArgumentSlot<State>('sinceState', (v) => v.value);
  final maxChanges = PrimitiveArgumentSlot<int>("maxChanges");

  ChangesMethod({
    required super.accountId,
    required Argument<State> sinceState,
  }) {
    _sinceState.set(sinceState);
  }

  @override
  get slots => [...super.slots, _sinceState, maxChanges];
}
