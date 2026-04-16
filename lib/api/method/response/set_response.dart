import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';

abstract class SetResponse<T> extends MethodResponse {
  final AccountId accountId;
  final State<T> newState;
  final State<T>? oldState;
  final Map<CreationId<T>, T>? created;
  final Map<Id<T>, T?>? updated;
  final List<Id<T>>? destroyed;
  final Map<CreationId<T>, SetError>? notCreated;
  final Map<Id<T>, SetError>? notUpdated;
  final Map<Id<T>, SetError>? notDestroyed;

  SetResponse({
    required this.accountId,
    required this.oldState,
    required this.newState,
    required this.created,
    required this.updated,
    required this.destroyed,
    required this.notCreated,
    required this.notUpdated,
    required this.notDestroyed,
  });

  static ({
    AccountId accountId,
    State<T>? oldState,
    State<T> newState,
    Map<CreationId<T>, T>? created,
    Map<Id<T>, T?>? updated,
    List<Id<T>>? destroyed,
    Map<CreationId<T>, SetError>? notCreated,
    Map<Id<T>, SetError>? notUpdated,
    Map<Id<T>, SetError>? notDestroyed,
  })
  parseJson<T>(Map<String, dynamic> json, T Function(dynamic) typeFromJson) => (
    accountId: AccountId.fromJson(json['accountId'] as String),
    oldState: json['oldState'] != null
        ? State<T>.fromJson(json['oldState'] as String)
        : null,
    newState: State<T>.fromJson(json['newState'] as String),
    created: (json['created'] as Map<String, dynamic>?)?.map(
      (key, value) => MapEntry(CreationId<T>(key), typeFromJson(value)),
    ),
    updated: (json['updated'] as Map<String, dynamic>?)?.map(
      (key, value) =>
          MapEntry(Id<T>(key), value != null ? typeFromJson(value) : null),
    ),
    destroyed: (json['destroyed'] as List<dynamic>?)
        ?.map((id) => Id<T>(id))
        .toList(),
    notCreated: (json['notCreated'] as Map<String, dynamic>?)?.map(
      (key, value) => MapEntry(CreationId<T>(key), SetError.fromJson(value)),
    ),
    notUpdated: (json['notUpdated'] as Map<String, dynamic>?)?.map(
      (key, value) => MapEntry(Id<T>(key), SetError.fromJson(value)),
    ),
    notDestroyed: (json['notDestroyed'] as Map<String, dynamic>?)?.map(
      (key, value) => MapEntry(Id<T>(key), SetError.fromJson(value)),
    ),
  );
}
