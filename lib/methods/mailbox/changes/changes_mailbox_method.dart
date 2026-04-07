import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/changes_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/methods/mailbox/changes/changes_mailbox_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:jmap_dart_client/src/converters/unsigned_int_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'changes_mailbox_method.g.dart';

@UnsignedIntNullableConverter()
@StateConverter()
@AccountIdConverter()
@JsonSerializable()
class ChangesMailboxMethod extends ChangesMethod<ChangesMailboxResponse> {
  ChangesMailboxMethod(
    AccountId accountId,
    State sinceState, {
    UnsignedInt? maxChanges,
  }) : super(accountId, sinceState, maxChanges: maxChanges);

  @override
  MethodName get methodName => MethodName('Mailbox/changes');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapMail,
  };

  factory ChangesMailboxMethod.fromJson(Map<String, dynamic> json) =>
      _$ChangesMailboxMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChangesMailboxMethodToJson(this);

  @override
  ChangesMailboxResponse deserializeResponse(Map<String, dynamic> json) {
    return ChangesMailboxResponse.fromJson(json);
  }
}
