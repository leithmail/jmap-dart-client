import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/methods/email/get_public_asset_response.dart';

class GetPublicAssetMethod
    extends MethodWithAccountId<GetPublicAssetResponse, ResultReference>
    with EmptyResultReferences {
  final ids = ListArgumentSlot<Id>('ids', (v) => v.value);

  GetPublicAssetMethod({required super.accountId});

  @override
  get slots => [...super.slots, ids];

  @override
  MethodName get methodName => MethodName('PublicAsset/get');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapPublicAsset,
  ];

  @override
  GetPublicAssetResponse responseFromJson(Map<String, dynamic> json) {
    return GetPublicAssetResponse.fromJson(json);
  }
}
