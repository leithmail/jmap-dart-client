import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/changes_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/mailbox/changes/changes_mailbox_response.dart';

class ChangesMailboxMethod
    extends ChangesMethod<ChangesMailboxResponse, ResultReference>
    with EmptyResultReferences {
  ChangesMailboxMethod({required super.accountId, required super.sinceState});

  @override
  MethodName get methodName => MethodName('Mailbox/changes');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapMail,
  ];

  @override
  ChangesMailboxResponse responseFromJson(Map<String, dynamic> json) {
    return ChangesMailboxResponse.fromJson(json);
  }
}
