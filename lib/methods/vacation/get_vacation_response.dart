import 'package:jmap_dart_client/api/method/response/get_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/vacation/vacation_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_vacation_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable(createToJson: false)
class GetVacationResponse extends GetResponse<VacationResponse> {
  GetVacationResponse(
    AccountId accountId,
    State state,
    List<VacationResponse> list,
    List<Id>? notFound,
  ) : super(accountId, state, list, notFound);

  factory GetVacationResponse.fromJson(Map<String, dynamic> json) =>
      _$GetVacationResponseFromJson(json);
}
