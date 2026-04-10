import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/patch_object.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class SetMethod<R extends MethodResponse, T>
    extends MethodRequiringAccountId<R>
    with
        OptionalIfInState,
        OptionalCreate<T>,
        OptionalDestroy,
        OptionalUpdate,
        OptionalReferenceDestroy {
  SetMethod(AccountId accountId) : super(accountId);
}

abstract class SetMethodNoNeedAccountId<R extends MethodResponse, T>
    extends Method<R, ResultReference>
    with
        OptionalCreate<T>,
        OptionalDestroy,
        OptionalUpdate,
        OptionalReferenceDestroy {
  SetMethodNoNeedAccountId() : super();

  @override
  ResultReference resultReferencePaths(MethodCallId resultOf) =>
      resultReferenceDefault(resultOf);
}

mixin OptionalIfInState {
  @JsonKey(includeIfNull: false)
  State? ifInState;

  void addIfInState(State? state) {
    ifInState = state;
  }
}

mixin OptionalCreate<T> {
  @JsonKey(includeIfNull: false)
  Map<Id, T>? create;

  void addCreates(Map<Id, T> creates) {
    create ??= <Id, T>{};
    create?.addAll(creates);
  }

  void addCreate(Id id, T createItem) {
    create ??= <Id, T>{};
    create?.addAll({id: createItem});
  }
}

mixin OptionalUpdate {
  @JsonKey(includeIfNull: false)
  Map<Id, PatchObject>? update;

  void addUpdates(Map<Id, PatchObject> updates) {
    update ??= <Id, PatchObject>{};
    update?.addAll(updates);
  }
}

mixin OptionalDestroy {
  @JsonKey(includeIfNull: false)
  Set<Id>? destroy;

  void addDestroy(Set<Id> values) {
    destroy ??= <Id>{};
    destroy?.addAll(values);
  }
}

mixin OptionalUpdateSingleton<T> {
  @JsonKey(includeIfNull: false)
  Map<Id, T>? updateSingleton;

  void addUpdatesSingleton(Map<Id, T> updates) {
    updateSingleton ??= <Id, T>{};
    updateSingleton?.addAll(updates);
  }
}

mixin OptionalReferenceDestroy {
  @JsonKey(name: '#destroy', includeIfNull: false)
  ResultReference? referenceDestroy;

  void addReferenceDestroy(RequestInvocation invocation, ReferencePath path) {
    referenceDestroy = invocation.createResultReference(path);
  }
}
