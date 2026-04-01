import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class ChangesMethod<R extends MethodResponse>
    extends MethodRequiringAccountId<R> {
  final State sinceState;

  @JsonKey(includeIfNull: false)
  final UnsignedInt? maxChanges;

  ChangesMethod(AccountId accountId, this.sinceState, {this.maxChanges})
    : super(accountId);
}
