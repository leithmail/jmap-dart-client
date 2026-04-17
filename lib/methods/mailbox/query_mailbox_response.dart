import 'package:jmap_dart_client/api/method/response/query_response.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';

class QueryMailboxResponse extends QueryResponse<Mailbox> {
  QueryMailboxResponse({
    required super.accountId,
    required super.queryState,
    required super.ids,
    required super.canCalculateChanges,
    required super.position,
    required super.total,
    required super.limit,
  });

  factory QueryMailboxResponse.fromJson(Map<String, dynamic> json) {
    final parsed = QueryResponse.parseJson<Mailbox>(json);
    return QueryMailboxResponse(
      accountId: parsed.accountId,
      queryState: parsed.queryState,
      ids: parsed.ids,
      canCalculateChanges: parsed.canCalculateChanges,
      position: parsed.position,
      total: parsed.total,
      limit: parsed.limit,
    );
  }
}
