import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

class UnreadEmailsConverter implements JsonConverter<UnreadEmails?, int?> {
  const UnreadEmailsConverter();

  @override
  UnreadEmails? fromJson(int? json) {
    return json != null ? UnreadEmails(UnsignedInt(json)) : null;
  }

  @override
  int? toJson(UnreadEmails? object) {
    return object?.value.value.toInt();
  }
}
