import 'package:jmap_dart_client/api/method/request/changes_method.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/entities/capability/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:jmap_dart_client/src/converters/unsigned_int_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'changes_email_method.g.dart';

@UnsignedIntNullableConverter()
@StateConverter()
@AccountIdConverter()
@JsonSerializable()
class ChangesEmailMethod extends ChangesMethod {
  ChangesEmailMethod(
    AccountId accountId,
    State sinceState, {
    UnsignedInt? maxChanges,
  }) : super(accountId, sinceState);

  @override
  MethodName get methodName => MethodName('Email/changes');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

  factory ChangesEmailMethod.fromJson(Map<String, dynamic> json) =>
      _$ChangesEmailMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChangesEmailMethodToJson(this);
}
