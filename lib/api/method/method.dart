import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';

abstract class Method<R extends MethodResponse> {
  MethodName get methodName;

  Set<CapabilityIdentifier> get requiredCapabilities;

  Map<String, dynamic> toJson();
  R responseFromJson(Map<String, dynamic> json);
}

abstract class MethodRequiringAccountId<R extends MethodResponse>
    extends Method<R> {
  final AccountId accountId;

  MethodRequiringAccountId(this.accountId);
}

class MethodName with EquatableMixin {
  final String value;

  MethodName(this.value);

  @override
  List<Object> get props => [value];
}
