import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/changes_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/methods/mailbox/changes/changes_mailbox_response.dart';

class ChangesMailboxMethod extends ChangesMethod<ChangesMailboxResponse> {
  ChangesMailboxMethod(
    AccountId accountId,
    State sinceState, {
    UnsignedInt? maxChanges,
  }) : super(accountId, sinceState, maxChanges: maxChanges);

  @override
  MethodName methodName() => MethodName('Mailbox/changes');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapMail,
  };

  @override
  ChangesMailboxResponse responseFromJson(Map<String, dynamic> json) {
    return ChangesMailboxResponse.fromJson(json);
  }
}
