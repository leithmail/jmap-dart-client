import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/email/email_submission_id.dart';
import 'package:json_annotation/json_annotation.dart';

class EmailSubmissionIdNullableConverter
    implements JsonConverter<EmailSubmissionId?, String?> {
  const EmailSubmissionIdNullableConverter();

  @override
  EmailSubmissionId? fromJson(String? json) {
    return json != null ? EmailSubmissionId(Id(json)) : null;
  }

  @override
  String? toJson(EmailSubmissionId? object) {
    return object?.id.value;
  }
}
