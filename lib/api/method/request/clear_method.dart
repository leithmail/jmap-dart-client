import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';

abstract class ClearMethod<R extends MethodResponse>
    extends MethodRequiringAccountId<R> {
  ClearMethod(AccountId accountId) : super(accountId);
}
