import 'package:jmap_dart_client/api/method/response/get_response.dart';
import 'package:jmap_dart_client/entities/vacation/vacation.dart';

class GetVacationResponse extends GetResponse<Vacation> {
  GetVacationResponse({
    required super.accountId,
    required super.state,
    required super.list,
    required super.notFound,
  });
  factory GetVacationResponse.fromJson(Map<String, dynamic> json) {
    final parsed = GetResponse.parseJson(
      json,
      (item) => Vacation.fromJson(item),
    );
    return GetVacationResponse(
      accountId: parsed.accountId,
      state: parsed.state,
      list: parsed.list,
      notFound: parsed.notFound,
    );
  }
}
