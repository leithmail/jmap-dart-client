import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/vacation/get_vacation_response.dart';

class GetVacationMethod extends GetMethod<GetVacationResponse> {
  GetVacationMethod(AccountId accountId) : super(accountId);

  @override
  MethodName methodName() => MethodName('VacationResponse/get');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapVacationResponse,
  };

  @override
  GetVacationResponse responseFromJson(Map<String, dynamic> json) {
    return GetVacationResponse.fromJson(json);
  }
}
