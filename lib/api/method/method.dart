import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:meta/meta.dart';

abstract class Method<R extends MethodResponse, Q extends ResultReference> {
  MethodName get methodName;

  @mustCallSuper
  List<CapabilityIdentifier> get requiredCapabilities => [
    CapabilityIdentifier.jmapCore,
  ];

  @mustCallSuper
  List<ArgumentSlotBase> get slots => [];

  @nonVirtual
  Map<String, dynamic> toJson() => Map.fromEntries(
    slots.map((s) => s.toEntry()).whereType<MapEntry<String, dynamic>>(),
  );

  R responseFromJson(Map<String, dynamic> json);
  Q resultReferences(MethodCallId resultOf);
}

mixin EmptyResultReferences<T, R extends MethodResponse>
    on Method<R, ResultReference> {
  @override
  ResultReference resultReferences(MethodCallId resultOf) => ResultReference(
    name: methodName,
    resultOf: resultOf,
    path: ReferencePath.root,
  );
}

abstract class MethodWithAccountId<
  R extends MethodResponse,
  Q extends ResultReference
>
    extends Method<R, Q> {
  final _accountId = ArgumentSlot<AccountId>('accountId', (v) => v.toJson());

  MethodWithAccountId({required Argument<AccountId> accountId}) {
    _accountId(accountId);
  }

  @override
  get slots => [...super.slots, _accountId];
}

class MethodName with EquatableMixin {
  final String value;

  MethodName(this.value);

  @override
  List<Object> get props => [value];
}
