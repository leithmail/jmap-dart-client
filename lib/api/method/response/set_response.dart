import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';

abstract class SetResponse<T> extends ResponseRequiringAccountId {
  final State? oldState;
  final State? newState;
  final Map<Id, T>? created;
  final Map<Id, T?>? updated;
  final Set<Id>? destroyed;
  final Map<Id, SetError>? notCreated;
  final Map<Id, SetError>? notUpdated;
  final Map<Id, SetError>? notDestroyed;

  SetResponse(
    AccountId accountId, {
    this.newState,
    this.oldState,
    this.created,
    this.updated,
    this.destroyed,
    this.notCreated,
    this.notUpdated,
    this.notDestroyed,
  }) : super(accountId);
}

abstract class SetResponseNoAccount<T> extends MethodResponse {
  final Map<Id, T>? created;
  final Map<Id, T?>? updated;
  final Set<Id>? destroyed;
  final Map<Id, SetError>? notCreated;
  final Map<Id, SetError>? notUpdated;
  final Map<Id, SetError>? notDestroyed;

  SetResponseNoAccount({
    this.created,
    this.updated,
    this.destroyed,
    this.notCreated,
    this.notUpdated,
    this.notDestroyed,
  }) : super();
}
