import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';

abstract class ChangesResponse extends ResponseRequiringAccountId {
  final State oldState;
  final State newState;
  final bool hasMoreChanges;
  final Set<Id> created;
  final Set<Id> updated;
  final Set<Id> destroyed;

  ChangesResponse(
    AccountId accountId,
    this.oldState,
    this.newState,
    this.hasMoreChanges,
    this.created,
    this.updated,
    this.destroyed,
  ) : super(accountId);
}
