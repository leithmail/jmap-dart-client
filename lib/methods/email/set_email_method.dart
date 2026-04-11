import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/methods/email/set_email_response.dart';

class SetEmailMethod extends SetMethod<SetEmailResponse, Email> {
  SetEmailMethod(AccountId accountId) : super(accountId);

  @override
  MethodName methodName() => MethodName('Email/set');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapCore,
  };

  @override
  SetEmailResponse responseFromJson(Map<String, dynamic> json) {
    return SetEmailResponse.fromJson(json);
  }

  @override
  Object? typeToJson(Email v) => v.toJson();
}
