import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

class TotalEmailConverter implements JsonConverter<TotalEmails?, int?> {
  const TotalEmailConverter();

  @override
  TotalEmails? fromJson(int? json) {
    return json != null ? TotalEmails(UnsignedInt(json)) : null;
  }

  @override
  int? toJson(TotalEmails? object) {
    return object?.value.value.toInt();
  }
}
