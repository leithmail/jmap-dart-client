import 'package:jmap_dart_client/api/method/response/get_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/quota/quota.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_quota_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable()
class GetQuotaResponse extends GetResponse<Quota> {
  GetQuotaResponse(
    AccountId accountId,
    State state,
    List<Quota> list,
    List<Id>? notFound,
  ) : super(accountId, state, list, notFound);

  factory GetQuotaResponse.fromJson(Map<String, dynamic> json) =>
      _$GetQuotaResponseFromJson(json);

  static GetQuotaResponse deserialize(Map<String, dynamic> json) {
    return GetQuotaResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetQuotaResponseToJson(this);

  @override
  List<Object?> get props => [accountId, state, list, notFound];
}
