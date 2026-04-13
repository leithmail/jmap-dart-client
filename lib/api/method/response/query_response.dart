import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';

abstract class QueryResponse extends ResponseRequiringAccountId {
  final State queryState;
  final bool canCalculateChanges;
  final int position;
  final List<Id> ids;
  final int? total;
  final int? limit;

  QueryResponse(
    AccountId accountId,
    this.queryState,
    this.canCalculateChanges,
    this.position,
    this.ids,
    this.total,
    this.limit,
  ) : super(accountId);
}
