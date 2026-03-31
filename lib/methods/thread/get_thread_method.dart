import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/capability/capability_identifier.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/properties_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_thread_method.g.dart';

@JsonSerializable(
  includeIfNull: false,
  explicitToJson: true,
  converters: [AccountIdConverter(), IdConverter(), PropertiesConverter()],
)
class GetThreadMethod extends GetMethod {
  GetThreadMethod(super.accountId);

  @override
  MethodName get methodName => MethodName('Thread/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

  @override
  Map<String, dynamic> toJson() => _$GetThreadMethodToJson(this);
}
