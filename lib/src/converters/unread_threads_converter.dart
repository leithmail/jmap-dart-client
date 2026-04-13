import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

class UnreadThreadsConverter implements JsonConverter<UnreadThreads?, int?> {
  const UnreadThreadsConverter();

  @override
  UnreadThreads? fromJson(int? json) {
    return json != null ? UnreadThreads(json) : null;
  }

  @override
  int? toJson(UnreadThreads? object) {
    return object?.value.toInt();
  }
}
