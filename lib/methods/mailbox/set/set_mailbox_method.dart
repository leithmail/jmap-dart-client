import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/methods/mailbox/set/set_mailbox_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/set/set_method_properties_converter.dart';
import 'package:json_annotation/json_annotation.dart';

class SetMailboxMethod extends SetMethod<SetMailboxResponse, Mailbox>
    with OptionalOnDestroyRemoveEmails {
  SetMailboxMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('Mailbox/set');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapMail,
    CapabilityIdentifier.jmapCore,
  };

  @override
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(accountId),
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('ifInState', ifInState?.value);
    writeNotNull(
      'create',
      create?.map(
        (id, create) =>
            SetMethodPropertiesConverter().fromMapIdToJson(id, create.toJson()),
      ),
    );
    writeNotNull(
      'update',
      update?.map(
        (id, update) =>
            SetMethodPropertiesConverter().fromMapIdToJson(id, update.toJson()),
      ),
    );
    writeNotNull(
      'destroy',
      destroy
          ?.map((destroyId) => const IdConverter().toJson(destroyId))
          .toList(),
    );
    writeNotNull('onDestroyRemoveEmails', onDestroyRemoveEmails);

    return val;
  }

  @override
  SetMailboxResponse deserializeResponse(Map<String, dynamic> json) {
    return SetMailboxResponse.deserialize(json);
  }
}

mixin OptionalOnDestroyRemoveEmails {
  @JsonKey(includeIfNull: false)
  bool? onDestroyRemoveEmails;

  void addOnDestroyRemoveEmails(bool value) {
    onDestroyRemoveEmails = value;
  }
}
