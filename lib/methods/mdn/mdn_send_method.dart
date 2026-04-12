import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/send_method.dart';
import 'package:jmap_dart_client/api/request/patch_object.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/email/email_submission_id.dart';
import 'package:jmap_dart_client/entities/identity/identity.dart';
import 'package:jmap_dart_client/entities/mdn/mdn.dart';
import 'package:jmap_dart_client/methods/mdn/mdn_send_response.dart';
import 'package:jmap_dart_client/src/converters/identities/identity_id_converter.dart';
import 'package:jmap_dart_client/src/converters/set/set_method_properties_converter.dart';

class MDNSendMethod extends SendMethod<MDNSendResponse, ResultReference, MDN>
    with EmptyResultReferences {
  final _identityId = ArgumentSlot<IdentityId>(
    'identityId',
    (v) => IdentityIdConverter().toJson(v),
  );
  final onSuccessUpdateEmail =
      ArgumentSlot<Map<EmailSubmissionId, PatchObject>?>(
        'onSuccessUpdateEmail',
        (v) => v?.map(
          (id, update) => SetMethodPropertiesConverter()
              .fromMapEmailSubmissionIdToJson(id, update),
        ),
      );

  MDNSendMethod({
    required super.accountId,
    required super.send,
    required Argument<IdentityId> identityId,
  }) {
    _identityId.set(identityId);
  }

  @override
  get slots => [...super.slots, _identityId, onSuccessUpdateEmail];

  @override
  MethodName get methodName => MethodName('MDN/send');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapMdn,
  ];

  @override
  MDNSendResponse responseFromJson(Map<String, dynamic> json) {
    return MDNSendResponse.fromJson(json);
  }
}
