import 'package:jmap_dart_client/api/method/response/get_response.dart';
import 'package:jmap_dart_client/entities/thread/thread.dart';

class GetThreadResponse extends GetResponse<Thread> {
  GetThreadResponse({
    required super.accountId,
    required super.state,
    required super.list,
    required super.notFound,
  });
  factory GetThreadResponse.fromJson(Map<String, dynamic> json) {
    final parsed = GetResponse.parseJson(json, (item) => Thread.fromJson(item));
    return GetThreadResponse(
      accountId: parsed.accountId,
      state: parsed.state,
      list: parsed.list,
      notFound: parsed.notFound,
    );
  }
}
