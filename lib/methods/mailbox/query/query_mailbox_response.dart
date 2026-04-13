import 'package:jmap_dart_client/api/method/response/query_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'query_mailbox_response.g.dart';

@IdConverter()
@StateConverter()
@AccountIdConverter()
@JsonSerializable(createToJson: false)
class QueryMailboxResponse extends QueryResponse {
  QueryMailboxResponse(
    AccountId accountId,
    State queryState,
    bool canCalculateChanges,
    int position,
    List<Id> ids,
    int? total,
    int? limit,
  ) : super(
        accountId,
        queryState,
        canCalculateChanges,
        position,
        ids,
        total,
        limit,
      );

  factory QueryMailboxResponse.fromJson(Map<String, dynamic> json) =>
      _$QueryMailboxResponseFromJson(json);
}
