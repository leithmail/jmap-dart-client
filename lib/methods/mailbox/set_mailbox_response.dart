import 'package:jmap_dart_client/api/method/response/set_response.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';

class SetMailboxResponse extends SetResponse<Mailbox> {
  SetMailboxResponse({
    required super.accountId,
    required super.oldState,
    required super.newState,
    required super.created,
    required super.updated,
    required super.destroyed,
    required super.notCreated,
    required super.notUpdated,
    required super.notDestroyed,
  });

  factory SetMailboxResponse.fromJson(Map<String, dynamic> json) {
    final parsed = SetResponse.parseJson(
      json,
      (item) => Mailbox.fromJson(item),
    );
    return SetMailboxResponse(
      accountId: parsed.accountId,
      oldState: parsed.oldState,
      newState: parsed.newState,
      created: parsed.created,
      updated: parsed.updated,
      destroyed: parsed.destroyed,
      notCreated: parsed.notCreated,
      notUpdated: parsed.notUpdated,
      notDestroyed: parsed.notDestroyed,
    );
  }
}
