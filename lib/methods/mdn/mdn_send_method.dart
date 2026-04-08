import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/send_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/identity/identity.dart';
import 'package:jmap_dart_client/entities/mdn/mdn.dart';
import 'package:jmap_dart_client/methods/email/set_email_submission_method.dart';
import 'package:jmap_dart_client/methods/mdn/mdn_send_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/identities/identity_id_converter.dart';
import 'package:jmap_dart_client/src/converters/send/send_method_properties_converter.dart';
import 'package:jmap_dart_client/src/converters/set/set_method_properties_converter.dart';

class MDNSendMethod extends SendMethod<MDNSendResponse, MDN>
    with OptionalOnSuccessUpdateEmail {
  final IdentityId identityId;

  MDNSendMethod(super.accountId, super.send, this.identityId);

  @override
  MethodName get methodName => MethodName('MDN/send');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapMdn,
  };

  @override
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(accountId),
      'send': send.map(
        (id, mdn) =>
            SendMethodPropertiesConverter().fromMapIdToJson(id, mdn.toJson()),
      ),
      'identityId': const IdentityIdConverter().toJson(identityId),
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull(
      'onSuccessUpdateEmail',
      onSuccessUpdateEmail?.map(
        (id, update) => SetMethodPropertiesConverter()
            .fromMapEmailSubmissionIdToJson(id, update),
      ),
    );
    return val;
  }

  @override
  MDNSendResponse responseFromJson(Map<String, dynamic> json) {
    return MDNSendResponse.deserialize(json);
  }
}
