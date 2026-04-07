import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/mailbox/get/get_mailbox_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/properties_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_mailbox_method.g.dart';

@IdConverter()
@AccountIdConverter()
@PropertiesConverter()
@JsonSerializable(explicitToJson: true)
class GetMailboxMethod extends GetMethod<GetMailboxResponse> {
  GetMailboxMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('Mailbox/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

  Set<CapabilityIdentifier> get requiredCapabilitiesSupportTeamMailboxes => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapTeamMailboxes,
  };

  factory GetMailboxMethod.fromJson(Map<String, dynamic> json) =>
      _$GetMailboxMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetMailboxMethodToJson(this);

  @override
  GetMailboxResponse deserializeResponse(Map<String, dynamic> json) {
    return GetMailboxResponse.deserialize(json);
  }
}
