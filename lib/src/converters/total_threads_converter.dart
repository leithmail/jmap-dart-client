import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

class TotalThreadsConverter implements JsonConverter<TotalThreads?, int?> {
  const TotalThreadsConverter();

  @override
  TotalThreads? fromJson(int? json) {
    return json != null ? TotalThreads(json) : null;
  }

  @override
  int? toJson(TotalThreads? object) {
    return object?.value.toInt();
  }
}
