import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/email/public_asset.dart';
import 'package:jmap_dart_client/methods/email/set_public_asset_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/set/set_method_properties_converter.dart';

class SetPublicAssetMethod
    extends SetMethod<SetPublicAssetResponse, PublicAsset> {
  SetPublicAssetMethod(super.accountId);

  @override
  MethodName methodName() => MethodName('PublicAsset/set');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapPublicAsset,
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

    return val;
  }

  @override
  SetPublicAssetResponse responseFromJson(Map<String, dynamic> json) {
    return SetPublicAssetResponse.fromJson(json);
  }
}
