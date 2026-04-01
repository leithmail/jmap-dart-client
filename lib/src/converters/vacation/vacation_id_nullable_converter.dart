import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/vacation/vacation_id.dart';
import 'package:json_annotation/json_annotation.dart';

class VacationIdNullableConverter
    implements JsonConverter<VacationId?, String?> {
  const VacationIdNullableConverter();

  @override
  VacationId? fromJson(String? json) =>
      json != null ? VacationId(Id(json)) : null;

  @override
  String? toJson(VacationId? object) => object?.id.value;
}
