import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/api/request/result_reference_tree.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';

abstract class Method<R extends MethodResponse, F extends ResultReferenceTree> {
  MethodName methodName();

  Set<CapabilityIdentifier> requiredCapabilities();

  Map<String, dynamic> toJson();
  R responseFromJson(Map<String, dynamic> json);
  F resultReferenceTree(MethodCallId resultOf);
}

abstract class MethodRequiringAccountId<R extends MethodResponse>
    extends Method<R, ResultReferenceTree> {
  final AccountId accountId;

  MethodRequiringAccountId(this.accountId);
  ResultReferenceTree resultReferenceTree(MethodCallId resultOf) =>
      ResultReferenceTree(
        ResultReference(
          name: methodName(),
          resultOf: resultOf,
          path: ReferencePath.root,
        ),
      );
}

class MethodName with EquatableMixin {
  final String value;

  MethodName(this.value);

  @override
  List<Object> get props => [value];
}
