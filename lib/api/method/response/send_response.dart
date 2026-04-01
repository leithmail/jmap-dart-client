import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/errors/set_error.dart';

abstract class SendResponse<T> extends ResponseRequiringAccountId {
  final Map<Id, T>? sent;
  final Map<Id, SetError>? notSent;

  SendResponse(AccountId accountId, {this.sent, this.notSent})
    : super(accountId);
}
