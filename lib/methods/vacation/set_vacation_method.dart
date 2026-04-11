import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/vacation/vacation_response.dart';
import 'package:jmap_dart_client/methods/vacation/set_vacation_response.dart';

class SetVacationMethod extends SetMethod<SetVacationResponse, VacationResponse>
    with
        OptionalUpdateSingleton<
          VacationResponse,
          SetVacationResponse,
          ResultReference
        > {
  SetVacationMethod(AccountId accountId) : super(accountId);

  @override
  MethodName methodName() => MethodName('VacationResponse/set');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapVacationResponse,
  };

  @override
  Object? typeToJson(VacationResponse v) => v.toJson();

  @override
  SetVacationResponse responseFromJson(Map<String, dynamic> json) {
    return SetVacationResponse.fromJson(json);
  }
}
