import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';

abstract class QueryResponse<T> extends MethodResponse {
  final AccountId accountId;
  final QueryState<T> queryState;
  final bool canCalculateChanges;
  final int position;
  final List<Id<T>> ids;
  final int? total;
  final int? limit;

  QueryResponse({
    required this.accountId,
    required this.queryState,
    required this.canCalculateChanges,
    required this.position,
    required this.ids,
    required this.total,
    required this.limit,
  });

  static ({
    AccountId accountId,
    QueryState<T> queryState,
    bool canCalculateChanges,
    int position,
    List<Id<T>> ids,
    int? total,
    int? limit,
  })
  parseJson<T>(Map<String, dynamic> json) => (
    accountId: AccountId.fromJson(json['accountId'] as String),
    queryState: QueryState<T>.fromJson(json['queryState'] as String),
    canCalculateChanges: json['canCalculateChanges'] as bool,
    position: json['position'] as int,
    ids: (json['ids'] as List<dynamic>).map((id) => Id<T>(id)).toList(),
    total: json['total'] as int?,
    limit: json['limit'] as int?,
  );
}

class QueryState<T> extends State<T> {
  QueryState(String value) : super(value);
  factory QueryState.fromJson(String value) => QueryState(value);
}
