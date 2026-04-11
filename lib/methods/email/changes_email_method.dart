import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/changes_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/methods/email/changes_email_response.dart';

class ChangesEmailMethod extends ChangesMethod<ChangesEmailResponse> {
  ChangesEmailMethod(
    AccountId accountId,
    State sinceState, {
    UnsignedInt? maxChanges,
  }) : super(accountId, sinceState);

  @override
  MethodName methodName() => MethodName('Email/changes');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

  @override
  ChangesEmailResponse responseFromJson(Map<String, dynamic> json) {
    return ChangesEmailResponse.fromJson(json);
  }
}
