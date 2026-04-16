import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';

abstract class ChangesResponse<T> extends MethodResponse {
  final AccountId accountId;
  final State<T> oldState;
  final State<T> newState;
  final bool hasMoreChanges;
  final List<Id<T>> created;
  final List<Id<T>> updated;
  final List<Id<T>> destroyed;

  ChangesResponse({
    required this.accountId,
    required this.oldState,
    required this.newState,
    required this.hasMoreChanges,
    required this.created,
    required this.updated,
    required this.destroyed,
  });

  static ({
    AccountId accountId,
    State<T> oldState,
    State<T> newState,
    bool hasMoreChanges,
    List<Id<T>> created,
    List<Id<T>> updated,
    List<Id<T>> destroyed,
  })
  parseJson<T>(Map<String, dynamic> json) => (
    accountId: AccountId.fromJson(json['accountId'] as String),
    oldState: State<T>.fromJson(json['oldState'] as String),
    newState: State<T>.fromJson(json['newState'] as String),
    hasMoreChanges: json['hasMoreChanges'] as bool,
    created: (json['created'] as List<dynamic>).map((id) => Id<T>(id)).toList(),
    updated: (json['updated'] as List<dynamic>).map((id) => Id<T>(id)).toList(),
    destroyed: (json['destroyed'] as List<dynamic>)
        .map((id) => Id<T>(id))
        .toList(),
  );
}
