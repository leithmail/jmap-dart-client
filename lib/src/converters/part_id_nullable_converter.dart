import 'package:jmap_dart_client/entities/email/email_body_part.dart';
import 'package:json_annotation/json_annotation.dart';

class PartIdNullableConverter implements JsonConverter<PartId?, String?> {
  const PartIdNullableConverter();

  @override
  PartId? fromJson(String? json) => json != null ? PartId(json) : null;

  @override
  String? toJson(PartId? object) => object?.value;
}
