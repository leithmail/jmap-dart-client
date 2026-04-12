import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';

abstract class ClearMethod<R extends MethodResponse, Q extends ResultReference>
    extends MethodWithAccountId<R, Q> {
  ClearMethod({required super.accountId});
}
