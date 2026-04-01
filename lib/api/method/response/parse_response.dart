import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';

abstract class ParseResponse<T> extends ResponseRequiringAccountId {
  final Map<Id, T>? parsed;
  final List<Id>? notParsable;
  final List<Id>? notFound;

  ParseResponse(
    AccountId accountId, {
    this.parsed,
    this.notParsable,
    this.notFound,
  }) : super(accountId);
}
