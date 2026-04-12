import 'dart:core';

import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/patch_object.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';

abstract class SetMethod<R extends MethodResponse, Q extends ResultReference, T>
    extends MethodWithAccountId<R, Q> {
  SetMethod({required super.accountId});

  Object? typeToJson(T v);

  final ifInState = ArgumentSlot<State>('ifInState', (v) => v.value);
  late final create = MapArgumentSlot<Id, T>(
    'create',
    (k) => k.value,
    (v) => typeToJson(v),
  );
  final update = MapArgumentSlot<Id, PatchObject>(
    'update',
    (k) => k.value,
    (v) => v.toJson(),
  );
  final destroy = ListArgumentSlot<Id>('destroy', (v) => v.value);
  late final updateSingleton = MapArgumentSlot<Id, T>(
    'update',
    (k) => k.value,
    (v) => typeToJson(v),
  );

  @override
  get slots => [
    ...super.slots,
    ifInState,
    create,
    update,
    destroy,
    updateSingleton,
  ];
}
