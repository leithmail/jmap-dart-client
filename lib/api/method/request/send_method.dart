import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/mdn/mdn.dart';

abstract class SendMethod<R extends MethodResponse, T>
    extends MethodRequiringAccountId<R> {
  final Map<Id, MDN> send;

  SendMethod(AccountId accountId, this.send) : super(accountId);
}
