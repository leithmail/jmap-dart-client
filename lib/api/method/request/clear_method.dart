import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/api/method/method.dart';

abstract class ClearMethod extends MethodRequiringAccountId {
  ClearMethod(AccountId accountId) : super(accountId);
}
