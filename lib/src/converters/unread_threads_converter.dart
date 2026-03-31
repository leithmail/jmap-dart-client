import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

class UnreadThreadsConverter implements JsonConverter<UnreadThreads?, int?> {
  const UnreadThreadsConverter();

  @override
  UnreadThreads? fromJson(int? json) {
    return json != null ? UnreadThreads(UnsignedInt(json)) : null;
  }

  @override
  int? toJson(UnreadThreads? object) {
    return object?.value.value.toInt();
  }
}
