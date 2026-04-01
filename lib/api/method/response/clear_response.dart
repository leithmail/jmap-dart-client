import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/errors/set_error.dart';

abstract class ClearResponse extends ResponseRequiringAccountId {
  final UnsignedInt? totalDeletedMessagesCount;
  final SetError? notCleared;

  ClearResponse(
    AccountId accountId,
    this.totalDeletedMessagesCount,
    this.notCleared,
  ) : super(accountId);
}
