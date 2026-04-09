import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/api/request/patch_object.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/email/email_submission.dart';
import 'package:jmap_dart_client/entities/email/email_submission_id.dart';
import 'package:jmap_dart_client/methods/email/set_email_submission_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/references_email_submission_id_converter.dart';
import 'package:jmap_dart_client/src/converters/set/set_method_properties_converter.dart';
import 'package:json_annotation/json_annotation.dart';

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
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(accountId),
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('ifInState', ifInState?.value);
    writeNotNull(
      'create',
      create?.map(
        (id, create) =>
            SetMethodPropertiesConverter().fromMapIdToJson(id, create.toJson()),
      ),
    );
    writeNotNull(
      'update',
      update?.map(
        (id, update) =>
            SetMethodPropertiesConverter().fromMapIdToJson(id, update.toJson()),
      ),
    );
    writeNotNull(
      'destroy',
      destroy
          ?.map((destroyId) => const IdConverter().toJson(destroyId))
          .toList(),
    );
    writeNotNull(
      'onSuccessUpdateEmail',
      onSuccessUpdateEmail?.map(
        (id, update) => SetMethodPropertiesConverter()
            .fromMapEmailSubmissionIdToJson(id, update),
      ),
    );
    writeNotNull(
      'onSuccessDestroyEmail',
      onSuccessDestroyEmail
          ?.map(
            (destroyId) =>
                const ReferencesEmailSubmissionIdConverter().toJson(destroyId),
          )
          .toList(),
    );

    return val;
  }

  @override
  SetEmailSubmissionResponse responseFromJson(Map<String, dynamic> json) {
    return SetEmailSubmissionResponse.fromJson(json);
  }
}

mixin OptionalOnSuccessUpdateEmail {
  @JsonKey(includeIfNull: false)
  Map<EmailSubmissionId, PatchObject>? onSuccessUpdateEmail;

  void addOnSuccessUpdateEmail(Map<EmailSubmissionId, PatchObject> values) {
    onSuccessUpdateEmail ??= <EmailSubmissionId, PatchObject>{};
    onSuccessUpdateEmail?.addAll(values);
  }
}

mixin OptionalOnSuccessDestroyEmail {
  @JsonKey(includeIfNull: false)
  Set<EmailSubmissionId>? onSuccessDestroyEmail;

  void addOnSuccessDestroyEmail(Set<EmailSubmissionId> values) {
    onSuccessDestroyEmail ??= <EmailSubmissionId>{};
    onSuccessDestroyEmail?.addAll(values);
  }
}
