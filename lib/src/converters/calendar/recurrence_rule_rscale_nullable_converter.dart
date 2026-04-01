import 'package:jmap_dart_client/entities/calendar/properties/recurrence_rule/recurrence_rule_rscale.dart';
import 'package:json_annotation/json_annotation.dart';

class RecurrenceRuleRScaleNullableConverter
    implements JsonConverter<RecurrenceRuleRScale?, String?> {
  const RecurrenceRuleRScaleNullableConverter();

  @override
  RecurrenceRuleRScale? fromJson(String? json) =>
      json != null ? RecurrenceRuleRScale(json) : null;

  @override
  String? toJson(RecurrenceRuleRScale? object) => object?.value;
}
