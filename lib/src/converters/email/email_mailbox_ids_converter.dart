import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';

class EmailMailboxIdsConverter {
  MapEntry<MailboxId, bool> parseEntry(String key, bool value) =>
      MapEntry(MailboxId(Id(key)), value);

  MapEntry<String, bool> toJson(MailboxId mailboxId, bool value) {
    return MapEntry(const IdConverter().toJson(mailboxId.id), value);
  }
}
