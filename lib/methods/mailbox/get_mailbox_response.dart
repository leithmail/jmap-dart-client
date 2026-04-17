import 'package:jmap_dart_client/api/method/response/get_response.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';

class GetMailboxResponse extends GetResponse<Mailbox> {
  GetMailboxResponse({
    required super.accountId,
    required super.state,
    required super.list,
    required super.notFound,
  });

  factory GetMailboxResponse.fromJson(Map<String, dynamic> json) {
    final parsed = GetResponse.parseJson(
      json,
      (item) => Mailbox.fromJson(item as Map<String, dynamic>),
    );
    return GetMailboxResponse(
      accountId: parsed.accountId,
      state: parsed.state,
      list: parsed.list,
      notFound: parsed.notFound,
    );
  }
}
