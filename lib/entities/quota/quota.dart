import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/quota/data_types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quota.g.dart';

@JsonSerializable(includeIfNull: false)
class Quota with EquatableMixin {
  final Id id;
  final ResourceType resourceType;
  final int? used;
  final int? hardLimit;
  final int? limit;
  final Scope scope;
  final String name;
  final List<DataType>? dataTypes;
  final List<DataType>? types;
  final int? warnLimit;
  final int? softLimit;
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
