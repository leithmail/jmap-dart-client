import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/api/request/patch_object.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/email/email_submission.dart';
import 'package:jmap_dart_client/entities/email/email_submission_id.dart';
import 'package:jmap_dart_client/methods/email/set_email_submission_response.dart';
import 'package:jmap_dart_client/src/converters/set/set_method_properties_converter.dart';

class SetEmailSubmissionMethod
    extends
        SetMethod<SetEmailSubmissionResponse, ResultReference, EmailSubmission>
    with EmptyResultReferences {
  final onSuccessUpdateEmail =
      ArgumentSlot<Map<EmailSubmissionId, PatchObject>?>(
        'onSuccessUpdateEmail',
        (v) => v?.map(
          (id, update) => SetMethodPropertiesConverter()
              .fromMapEmailSubmissionIdToJson(id, update),
        ),
      );

  final onSuccessDestroyEmail = ListArgumentSlot<EmailSubmissionId>(
    'onSuccessDestroyEmail',
    (v) => v.id.value,
  );

  SetEmailSubmissionMethod({required super.accountId});

  @override
  MethodName get methodName => MethodName('EmailSubmission/set');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapSubmission,
    CapabilityIdentifier.jmapMail,
  ];

  @override
  SetEmailSubmissionResponse responseFromJson(Map<String, dynamic> json) {
    return SetEmailSubmissionResponse.fromJson(json);
  }

  @override
  Object? typeToJson(EmailSubmission v) => v.toJson();

  @override
  get slots => [...super.slots, onSuccessUpdateEmail, onSuccessDestroyEmail];
}
