import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/mailbox/get/get_mailbox_response.dart';

class GetMailboxMethod extends GetMethod<GetMailboxResponse, ResultReference>
    with EmptyResultReferences {
  GetMailboxMethod({required super.accountId});

  @override
  MethodName get methodName => MethodName('Mailbox/get');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapMail,
  ];

  @override
  GetMailboxResponse responseFromJson(Map<String, dynamic> json) {
    return GetMailboxResponse.fromJson(json);
  }
}
