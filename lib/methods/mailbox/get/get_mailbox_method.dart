import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/mailbox/get/get_mailbox_response.dart';

class GetMailboxMethod extends GetMethod<GetMailboxResponse> {
  GetMailboxMethod(AccountId accountId) : super(accountId);

  @override
  MethodName methodName() => MethodName('Mailbox/get');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

  @override
  GetMailboxResponse responseFromJson(Map<String, dynamic> json) {
    return GetMailboxResponse.fromJson(json);
  }
}
