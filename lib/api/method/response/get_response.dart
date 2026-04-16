import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';

abstract class GetResponse<T> extends MethodResponse {
  final AccountId accountId;
  final State<T> state;
  final List<T> list;
  final List<Id<T>>? notFound;

  GetResponse({
    required this.accountId,
    required this.state,
    required this.list,
    required this.notFound,
  });

  static ({
    AccountId accountId,
    State<T> state,
    List<T> list,
    List<Id<T>>? notFound,
  })
  parseJson<T>(Map<String, dynamic> json, T Function(dynamic) typeFromJson) => (
    accountId: AccountId.fromJson(json['accountId'] as String),
    state: State<T>.fromJson(json['state'] as String),
    list: (json['list'] as List<dynamic>).map(typeFromJson).toList(),
    notFound: (json['notFound'] as List<dynamic>?)
        ?.map((id) => Id<T>(id))
        .toList(),
  );
}
