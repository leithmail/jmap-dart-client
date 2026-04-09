import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/method/result_references.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';

abstract class Method<R extends MethodResponse, F extends ResultReferences> {
  MethodName get methodName;

  Set<CapabilityIdentifier> get requiredCapabilities;

  Map<String, dynamic> toJson();
  R responseFromJson(Map<String, dynamic> json);
  F resultReferences(MethodCallId resultOf);
}

abstract class MethodRequiringAccountId<R extends MethodResponse>
    extends Method<R, ResultReferences> {
  final AccountId accountId;

  MethodRequiringAccountId(this.accountId);
  ResultReferences resultReferences(MethodCallId resultOf) =>
      ResultReferences(name: methodName, resultOf: resultOf);
}

class MethodName with EquatableMixin {
  final String value;

  MethodName(this.value);

  @override
  List<Object> get props => [value];
}
