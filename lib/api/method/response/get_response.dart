import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';

abstract class GetResponse<T> extends ResponseRequiringAccountId {
  final State state;
  final List<T> list;
  final List<Id>? notFound;

  GetResponse(AccountId accountId, this.state, this.list, this.notFound)
    : super(accountId);
}

abstract class GetResponseNoAccountId<T> extends MethodResponse {
  final List<T> list;
  final List<Id>? notFound;

  GetResponseNoAccountId(this.list, this.notFound) : super();
}
