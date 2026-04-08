import 'package:jmap_dart_client/api/method/response/get_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/identity/identity.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_identity_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable(createToJson: false)
class GetIdentityResponse extends GetResponse<Identity> {
  GetIdentityResponse(
    AccountId accountId,
    State state,
    List<Identity> list,
    List<Id>? notFound,
  ) : super(accountId, state, list, notFound);

  factory GetIdentityResponse.fromJson(Map<String, dynamic> json) =>
      _$GetIdentityResponseFromJson(json);

  static GetIdentityResponse deserialize(Map<String, dynamic> json) {
    return GetIdentityResponse.fromJson(json);
  }
}
