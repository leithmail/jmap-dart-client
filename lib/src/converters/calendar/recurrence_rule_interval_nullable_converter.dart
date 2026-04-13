import 'package:jmap_dart_client/entities/calendar/properties/recurrence_rule/recurrence_rule_interval.dart';
import 'package:json_annotation/json_annotation.dart';

class RecurrenceRuleIntervalNullableConverter
    implements JsonConverter<RecurrenceRuleInterval?, int?> {
  const RecurrenceRuleIntervalNullableConverter();

  @override
  RecurrenceRuleInterval? fromJson(int? json) =>
      json != null ? RecurrenceRuleInterval(json) : null;

  @override
  int? toJson(RecurrenceRuleInterval? object) => object?.value.toInt();
}
