import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/response/changes_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/state.dart';

abstract class ChangesMethod<
  T,
  R extends ChangesResponse<T>,
  Q extends ResultReference
>
    extends MethodWithAccountId<R, Q> {
  final _sinceState = ArgumentSlot<State<T>>('sinceState', (v) => v.value);
  final maxChanges = PrimitiveSlot<int>("maxChanges");

  ChangesMethod({
    required super.accountId,
    required Argument<State<T>> sinceState,
  }) {
    _sinceState(sinceState);
  }

  @override
  get slots => [...super.slots, _sinceState, maxChanges];
}
