import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/api/request/patch_object.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/email/email_submission.dart';
import 'package:jmap_dart_client/entities/email/email_submission_id.dart';
import 'package:jmap_dart_client/methods/email/set_email_submission_response.dart';
import 'package:jmap_dart_client/src/converters/references_email_submission_id_converter.dart';
import 'package:jmap_dart_client/src/converters/set/set_method_properties_converter.dart';

class SetEmailSubmissionMethod
    extends SetMethod<SetEmailSubmissionResponse, EmailSubmission>
    with OptionalOnSuccessUpdateEmail, OptionalOnSuccessDestroyEmail {
  SetEmailSubmissionMethod(AccountId accountId) : super(accountId);

  @override
  MethodName methodName() => MethodName('EmailSubmission/set');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapSubmission,
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapCore,
  };

  @override
  SetEmailSubmissionResponse responseFromJson(Map<String, dynamic> json) {
    return SetEmailSubmissionResponse.fromJson(json);
  }

  @override
  Object? typeToJson(EmailSubmission v) => v.toJson();
}

mixin OptionalOnSuccessUpdateEmail<
  R extends MethodResponse,
  F extends ResultReference
>
    on Method<R, F> {
  final onSuccessUpdateEmail =
      ArgumentSlot<Map<EmailSubmissionId, PatchObject>?>(
        'onSuccessUpdateEmail',
        (v) => v?.map(
          (id, update) => SetMethodPropertiesConverter()
              .fromMapEmailSubmissionIdToJson(id, update),
        ),
      );

  @override
  get slots => [...super.slots, onSuccessUpdateEmail];
}

mixin OptionalOnSuccessDestroyEmail<
  R extends MethodResponse,
  F extends ResultReference
>
    on Method<R, F> {
  final onSuccessDestroyEmail = ArgumentSlot<Set<EmailSubmissionId>?>(
    'onSuccessDestroyEmail',
    (v) => v
        ?.map(
          (destroyId) =>
              const ReferencesEmailSubmissionIdConverter().toJson(destroyId),
        )
        .toList(),
  );

  @override
  get slots => [...super.slots, onSuccessDestroyEmail];
}
