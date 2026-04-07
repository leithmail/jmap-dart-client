import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/set_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/vacation/vacation_response.dart';
import 'package:jmap_dart_client/methods/vacation/set_vacation_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/set/set_method_properties_converter.dart';

class SetVacationMethod extends SetMethod<SetVacationResponse, VacationResponse>
    with OptionalUpdateSingleton<VacationResponse> {
  SetVacationMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('VacationResponse/set');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapVacationResponse,
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
      'update',
      updateSingleton?.map(
        (id, update) =>
            SetMethodPropertiesConverter().fromMapIdToJson(id, update.toJson()),
      ),
    );

    return val;
  }

  @override
  SetVacationResponse deserializeResponse(Map<String, dynamic> json) {
    return SetVacationResponse.deserialize(json);
  }
}
