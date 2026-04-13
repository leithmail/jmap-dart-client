import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/vacation/get_vacation_response.dart';
import 'package:jmap_dart_client/methods/vacation/vacation_property.dart';

class GetVacationMethod
    extends GetMethod<GetVacationResponse, ResultReference, VacationProperty>
    with EmptyResultReferences {
  GetVacationMethod({required super.accountId});

  @override
  MethodName get methodName => MethodName('VacationResponse/get');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapVacationResponse,
  ];

  @override
  GetVacationResponse responseFromJson(Map<String, dynamic> json) {
    return GetVacationResponse.fromJson(json);
  }
}
