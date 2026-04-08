import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/entities/quota/data_types.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/quotas/data_type_converter.dart';
import 'package:jmap_dart_client/src/converters/unsigned_int_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quota.g.dart';

@DataTypeConverter()
@IdConverter()
@UnsignedIntNullableConverter()
@JsonSerializable(includeIfNull: false)
class Quota with EquatableMixin {
  final Id id;
  final ResourceType resourceType;
  final UnsignedInt? used;
  final UnsignedInt? hardLimit;
  final UnsignedInt? limit;
  final Scope scope;
  final String name;
  final List<DataType>? dataTypes;
  final List<DataType>? types;
  final UnsignedInt? warnLimit;
  final UnsignedInt? softLimit;
  final String? description;

  Quota(
    this.id,
    this.resourceType,
    this.scope,
    this.name, {
    this.used,
    this.hardLimit,
    this.limit,
    this.warnLimit,
    this.softLimit,
    this.description,
    this.types,
    this.dataTypes,
  });

  factory Quota.fromJson(Map<String, dynamic> json) => _$QuotaFromJson(json);

  Map<String, dynamic> toJson() => _$QuotaToJson(this);

  @override
  List<Object?> get props => [
    id,
    resourceType,
    used,
    scope,
    name,
    dataTypes,
    hardLimit,
    limit,
    warnLimit,
    softLimit,
    description,
    types,
  ];
}
