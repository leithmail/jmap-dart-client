import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/send_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/identity/identity.dart';
import 'package:jmap_dart_client/entities/mdn/mdn.dart';
import 'package:jmap_dart_client/methods/email/set_email_submission_method.dart';
import 'package:jmap_dart_client/methods/mdn/mdn_send_response.dart';
import 'package:jmap_dart_client/src/converters/identities/identity_id_converter.dart';

class MDNSendMethod extends SendMethod<MDNSendResponse, MDN>
    with OptionalOnSuccessUpdateEmail {
  final identityId = ArgumentSlot<IdentityId>(
    'identityId',
    (v) => IdentityIdConverter().toJson(v),
  );

  MDNSendMethod(super.accountId, super.send, IdentityId identityId) {
    this.identityId.set(identityId);
  }

  @override
  get slots => [...super.slots, identityId];

  @override
  MethodName methodName() => MethodName('MDN/send');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapMdn,
  };

  @override
  MDNSendResponse responseFromJson(Map<String, dynamic> json) {
    return MDNSendResponse.fromJson(json);
  }
}
