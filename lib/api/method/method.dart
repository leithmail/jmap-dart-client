import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/entities/capability/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';

abstract class Method<R extends MethodResponse> {
  MethodName get methodName;

  Set<CapabilityIdentifier> get requiredCapabilities;

  Map<String, dynamic> toJson();
  R deserializeResponse(Map<String, dynamic> json);
}

abstract class MethodRequiringAccountId<R extends MethodResponse>
    extends Method<R> {
  final AccountId accountId;

  MethodRequiringAccountId(this.accountId);
}
