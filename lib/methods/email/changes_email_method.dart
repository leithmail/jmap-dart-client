import 'package:jmap_dart_client/api/api.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/email/changes_email_response.dart';

class ChangesEmailMethod
    extends ChangesMethod<ChangesEmailResponse, ChangesEmailResultReferences> {
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

  @override
  ChangesEmailResultReferences resultReferences(MethodCallId resultOf) =>
      ChangesEmailResultReferences(
        name: methodName,
        resultOf: resultOf,
        path: ReferencePath.root,
      );
}
