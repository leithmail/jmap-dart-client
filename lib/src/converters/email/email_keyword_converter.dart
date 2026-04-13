import 'package:jmap_dart_client/entities/email/email_keyword.dart';

class EmailKeywordConverter {
  MapEntry<EmailKeyword, bool> parseEntry(String key, bool value) =>
      MapEntry(EmailKeyword(key), value);

  MapEntry<String, bool> toJson(EmailKeyword keyword, bool value) =>
      MapEntry(keyword.value, value);
}
