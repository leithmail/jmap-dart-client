import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/thread/get_thread_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/properties_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_thread_method.g.dart';

@AccountIdConverter()
@IdConverter()
@PropertiesConverter()
@JsonSerializable(includeIfNull: false, createFactory: false)
class GetThreadMethod extends GetMethod<GetThreadResponse> {
  GetThreadMethod(super.accountId);

  @override
  @JsonKey(includeToJson: false)
  MethodName get methodName => MethodName('Thread/get');

  @override
  @JsonKey(includeToJson: false)
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

  @override
  Map<String, dynamic> toJson() => _$GetThreadMethodToJson(this);

  @override
  GetThreadResponse deserializeResponse(Map<String, dynamic> json) {
    return GetThreadResponse.fromJson(json);
  }
}
