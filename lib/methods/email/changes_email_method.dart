import 'package:jmap_dart_client/api/api.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/methods/email/changes_email_response.dart';

class ChangesEmailMethod
    extends ChangesMethod<Email, ChangesEmailResponse, ResultReference>
    with EmptyResultReferences {
  ChangesEmailMethod({required super.accountId, required super.sinceState});

  @override
  MethodName get methodName => MethodName('Email/changes');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapMail,
  ];

  @override
  ChangesEmailResponse responseFromJson(Map<String, dynamic> json) {
    return ChangesEmailResponse.fromJson(json);
  }
}
