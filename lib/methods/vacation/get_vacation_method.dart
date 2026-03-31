import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/capability/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/properties_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_vacation_method.g.dart';

@IdConverter()
@AccountIdConverter()
@PropertiesConverter()
@JsonSerializable()
class GetVacationMethod extends GetMethod {
  GetVacationMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('VacationResponse/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapVacationResponse,
  };

  factory GetVacationMethod.fromJson(Map<String, dynamic> json) =>
      _$GetVacationMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetVacationMethodToJson(this);
}
