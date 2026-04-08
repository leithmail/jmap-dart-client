import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/calendar/properties/recurrence_rule/day_of_week.dart';
import 'package:jmap_dart_client/entities/calendar/properties/recurrence_rule/recurrence_rule_count.dart';
import 'package:jmap_dart_client/entities/calendar/properties/recurrence_rule/recurrence_rule_frequency.dart';
import 'package:jmap_dart_client/entities/calendar/properties/recurrence_rule/recurrence_rule_interval.dart';
import 'package:jmap_dart_client/entities/calendar/properties/recurrence_rule/recurrence_rule_rscale.dart';
import 'package:jmap_dart_client/entities/calendar/properties/recurrence_rule/recurrence_rule_skip.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/entities/core/utc_date.dart';
import 'package:jmap_dart_client/src/converters/calendar/recurrence_rule_count_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/calendar/recurrence_rule_interval_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/calendar/recurrence_rule_rscale_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/unsigned_int_converter.dart';
import 'package:jmap_dart_client/src/converters/utc_date_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recurrence_rule.g.dart';

@RecurrenceRuleCountNullableConverter()
@RecurrenceRuleIntervalNullableConverter()
@UnsignedIntConverter()
@RecurrenceRuleRScaleNullableConverter()
@UTCDateNullableConverter()
@JsonSerializable(includeIfNull: false)
class RecurrenceRule with EquatableMixin {
  final RecurrenceRuleFrequency? frequency;
  final RecurrenceRuleInterval? interval;
  final RecurrenceRuleRScale? rscale;
  final RecurrenceRuleSkip? skip;
  final DayOfWeek? firstDayOfWeek;
  final List<DayOfWeek>? byDay;
  final List<int>? byMonthDay;
  final List<String>? byMonth;
  final List<int>? byYearDay;
  final List<int>? byWeekNo;
  final List<UnsignedInt>? byHour;
  final List<UnsignedInt>? byMinute;
  final List<UnsignedInt>? bySecond;
  final List<int>? bySetPosition;
  final RecurrenceRuleCount? count;
  final UTCDate? until;

  RecurrenceRule({
    this.frequency,
    this.interval,
    this.rscale,
    this.skip,
    this.firstDayOfWeek,
    this.byDay,
    this.byMonthDay,
    this.byMonth,
    this.byYearDay,
    this.byWeekNo,
    this.byHour,
    this.byMinute,
    this.bySecond,
    this.bySetPosition,
    this.count,
    this.until,
  });

  factory RecurrenceRule.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceRuleFromJson(json);

  Map<String, dynamic> toJson() => _$RecurrenceRuleToJson(this);

  @override
  List<Object?> get props => [
    frequency,
    interval,
    rscale,
    skip,
    firstDayOfWeek,
    byDay,
    byMonthDay,
    byMonth,
    byYearDay,
    byWeekNo,
    byHour,
    byMinute,
    bySecond,
    bySetPosition,
    count,
    until,
  ];
}
