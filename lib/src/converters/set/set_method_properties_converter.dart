import 'package:jmap_dart_client/api/request/patch_object.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/email/email_submission_id.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/references_email_submission_id_converter.dart';

class SetMethodPropertiesConverter {
  MapEntry<String, dynamic> fromMapIdToJson(Id id, dynamic object) {
    return MapEntry(const IdConverter().toJson(id), object);
  }

  MapEntry<String, dynamic> fromMapEmailSubmissionIdToJson(
    EmailSubmissionId emailSubmissionId,
    dynamic object,
  ) {
    if (object is PatchObject) {
      return MapEntry(
        const ReferencesEmailSubmissionIdConverter().toJson(emailSubmissionId),
        object.toJson(),
      );
    } else {
      return MapEntry(
        const ReferencesEmailSubmissionIdConverter().toJson(emailSubmissionId),
        object,
      );
    }
  }
}
