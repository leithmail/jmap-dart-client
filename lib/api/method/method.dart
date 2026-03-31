import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/entities/capability/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';

abstract class Method {
  MethodName get methodName;

  Set<CapabilityIdentifier> get requiredCapabilities;

  Map<String, dynamic> toJson();
}

abstract class MethodRequiringAccountId extends Method {
  final AccountId accountId;

  MethodRequiringAccountId(this.accountId);
}
