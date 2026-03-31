import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';

abstract class QueryResponse extends ResponseRequiringAccountId {
  final State queryState;
  final bool canCalculateChanges;
  final UnsignedInt position;
  final Set<Id> ids;
  final UnsignedInt? total;
  final UnsignedInt? limit;

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
