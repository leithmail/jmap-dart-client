import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';

abstract class ParseMethod<R extends MethodResponse>
    extends MethodRequiringAccountId<R>
    with OptionalProperties {
  final Set<Id> blobIds;

  ParseMethod(AccountId accountId, this.blobIds) : super(accountId);
}
