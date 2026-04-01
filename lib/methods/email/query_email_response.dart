import 'package:jmap_dart_client/api/method/response/query_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:jmap_dart_client/src/converters/unsigned_int_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'query_email_response.g.dart';

@UnsignedIntConverter()
@IdConverter()
@StateConverter()
@AccountIdConverter()
@JsonSerializable()
class QueryEmailResponse extends QueryResponse {
  QueryEmailResponse(
    AccountId accountId,
    State queryState,
    bool canCalculateChanges,
    UnsignedInt position,
    Set<Id> ids,
    UnsignedInt? total,
    UnsignedInt? limit,
  ) : super(
        accountId,
        queryState,
        canCalculateChanges,
        position,
        ids,
        total,
        limit,
      );

  factory QueryEmailResponse.fromJson(Map<String, dynamic> json) =>
      _$QueryEmailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QueryEmailResponseToJson(this);

  @override
  List<Object?> get props => [
    accountId,
    queryState,
    canCalculateChanges,
    position,
    total,
    ids,
  ];
}
