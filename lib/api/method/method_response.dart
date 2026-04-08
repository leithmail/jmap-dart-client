import 'package:jmap_dart_client/entities/core/account_id.dart';

abstract class MethodResponse {}

abstract class ResponseRequiringAccountId extends MethodResponse {
  final AccountId accountId;

  ResponseRequiringAccountId(this.accountId);
}
