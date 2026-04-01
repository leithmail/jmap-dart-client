import 'package:jmap_dart_client/api/sort/comparator.dart';
import 'package:jmap_dart_client/entities/email/email_comparator_property.dart';
import 'package:jmap_dart_client/src/converters/collation_identifier_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/comparator_property_converter.dart';
import 'package:jmap_dart_client/src/converters/email_comparator_property_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_comparator.g.dart';

@CollationIdentifierNullableConverter()
@ComparatorPropertyConverter()
@EmailComparatorPropertyConverter()
@JsonSerializable()
class EmailComparator extends Comparator {
  EmailComparator(EmailComparatorProperty property) : super(property);

  factory EmailComparator.fromJson(Map<String, dynamic> json) =>
      _$EmailComparatorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EmailComparatorToJson(this);
}
