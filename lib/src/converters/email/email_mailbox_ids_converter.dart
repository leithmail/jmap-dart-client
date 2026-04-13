import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';

class EmailMailboxIdsConverter {
  MapEntry<MailboxId, bool> parseEntry(String key, bool value) =>
      MapEntry(MailboxId(key), value);

  MapEntry<String, bool> toJson(MailboxId mailboxId, bool value) {
    return MapEntry(mailboxId.toJson(), value);
  }
}
