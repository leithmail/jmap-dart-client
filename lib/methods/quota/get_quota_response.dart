import 'package:jmap_dart_client/api/method/response/get_response.dart';
import 'package:jmap_dart_client/entities/quota/quota.dart';

class GetQuotaResponse extends GetResponse<Quota> {
  GetQuotaResponse({
    required super.accountId,
    required super.state,
    required super.list,
    required super.notFound,
  });
  factory GetQuotaResponse.fromJson(Map<String, dynamic> json) {
    final parsed = GetResponse.parseJson(json, (item) => Quota.fromJson(item));
    return GetQuotaResponse(
      accountId: parsed.accountId,
      state: parsed.state,
      list: parsed.list,
      notFound: parsed.notFound,
    );
  }
}
