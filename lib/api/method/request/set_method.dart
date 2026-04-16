import 'dart:core';

import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/response/set_response.dart';
import 'package:jmap_dart_client/api/request/patch_object.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';

abstract class SetMethod<T, R extends SetResponse<T>, Q extends ResultReference>
    extends MethodWithAccountId<R, Q> {
  SetMethod({required super.accountId});

  Object? typeToJson(T v);

  final ifInState = ArgumentSlot<State<T>>('ifInState', (v) => v.value);
  late final create = MapSlot<CreationId<T>, T>(
    'create',
    (k) => k.value,
    (v) => typeToJson(v),
  );
  final update = MapSlot<Id<T>, PatchObject>(
    'update',
    (k) => k.value,
    (v) => v.toJson(),
  );
  final destroy = ListSlot<Id<T>>('destroy', (v) => v.value);

  @override
  get slots => [...super.slots, ifInState, create, update, destroy];
}
