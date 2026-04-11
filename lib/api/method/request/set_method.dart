import 'dart:core';

import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/patch_object.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';

abstract class SetMethod<R extends MethodResponse, T>
    extends MethodRequiringAccountId<R>
    with
        OptionalIfInState,
        OptionalCreate<T, R, ResultReference>,
        OptionalDestroy,
        OptionalUpdate {
  SetMethod(AccountId accountId) : super(accountId);
}

abstract class SetMethodNoNeedAccountId<R extends MethodResponse, T>
    extends Method<R, ResultReference>
    with
        OptionalCreate<T, R, ResultReference>,
        OptionalDestroy,
        OptionalUpdate {
  SetMethodNoNeedAccountId() : super();

  @override
  ResultReference resultReference(MethodCallId resultOf) =>
      resultReferenceDefault(resultOf);
}

mixin OptionalIfInState<R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  final ifInState = ArgumentSlot<State?>('ifInState', (v) => v?.value);

  @override
  get slots => [...super.slots, ifInState];
}

mixin OptionalCreate<T, R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  late final create = ArgumentSlot<Map<Id, T>?>(
    'create',
    (v) => v?.map((id, value) => MapEntry(id.value, typeToJson(value))),
  );

  Object? typeToJson(T v);

  @override
  get slots => [...super.slots, create];
}

mixin OptionalUpdate<R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  final update = ArgumentSlot<Map<Id, PatchObject>?>(
    'update',
    (v) => v?.map((id, value) => MapEntry(id.value, value.toJson())),
  );

  @override
  get slots => [...super.slots, update];
}

mixin OptionalDestroy<R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  final destroy = ArgumentSlot<Set<Id>?>(
    'destroy',
    (v) => v?.map((id) => id.value).toList(),
  );

  @override
  get slots => [...super.slots, destroy];
}

mixin OptionalUpdateSingleton<
  T,
  R extends MethodResponse,
  F extends ResultReference
>
    on Method<R, F> {
  late final updateSingleton = ArgumentSlot<Map<Id, T>?>(
    'update',
    (v) => v?.map((id, value) => MapEntry(id.value, typeToJson(value))),
  );

  Object? typeToJson(T v);

  @override
  get slots => [...super.slots, updateSingleton];
}
