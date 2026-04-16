import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/utc_date.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vacation.g.dart';

@JsonSerializable(includeIfNull: false)
class Vacation with EquatableMixin {
  final VacationId? id;
  final bool? isEnabled;
  final UTCDate? fromDate;
  final UTCDate? toDate;
  final String? subject;
  final String? textBody;
  final String? htmlBody;

  Vacation({
    this.id,
    this.isEnabled,
    this.fromDate,
    this.toDate,
    this.subject,
    this.textBody,
    this.htmlBody,
  });

  factory Vacation.fromJson(Map<String, dynamic> json) =>
      _$VacationFromJson(json);

  Map<String, dynamic> toJson() => _$VacationToJson(this);

  @override
  List<Object?> get props => [
    id,
    isEnabled,
    fromDate,
    toDate,
    subject,
    textBody,
    htmlBody,
  ];
}

typedef VacationId = Id<Vacation>;
