import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:meta/meta.dart';

abstract class Method<R extends MethodResponse, F extends ResultReference> {
  MethodName methodName();

  Set<CapabilityIdentifier> requiredCapabilities();

  List<ArgumentSlot<dynamic>> get slots => [];

  @nonVirtual
  Map<String, dynamic> toJson() => Map.fromEntries(
    slots.map((s) => s.toEntry()).whereType<MapEntry<String, dynamic>>(),
  );

  R responseFromJson(Map<String, dynamic> json);
  F resultReference(MethodCallId resultOf);

  @protected
  ResultReference resultReferenceDefault(MethodCallId resultOf) =>
      ResultReference(
        name: methodName(),
        resultOf: resultOf,
        path: ReferencePath.root,
      );
}

abstract class MethodRequiringAccountId<R extends MethodResponse>
    extends Method<R, ResultReference> {
  final accountId = ArgumentSlot<AccountId>(
    'accountId',
    (v) => AccountIdConverter().toJson(v),
  );

  MethodRequiringAccountId(AccountId accountId) {
    this.accountId.set(accountId);
  }

  @override
  List<ArgumentSlot<dynamic>> get slots => [...super.slots, accountId];

  @override
  ResultReference resultReference(MethodCallId resultOf) =>
      resultReferenceDefault(resultOf);
}

class MethodName with EquatableMixin {
  final String value;

  MethodName(this.value);

  @override
  List<Object> get props => [value];
}
