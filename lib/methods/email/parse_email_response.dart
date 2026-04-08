import 'package:jmap_dart_client/api/method/response/parse_response.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/src/utils/json_parsers.dart';

class ParseEmailResponse extends ParseResponse<Email> {
  ParseEmailResponse(
    super.accountId, {
    super.parsed,
    super.notParsable,
    super.notFound,
  });

  factory ParseEmailResponse.fromJson(Map<String, dynamic> json) {
    return ParseEmailResponse(
      JsonParsers().parsingAccountId(json),
      parsed: JsonParsers().parsingMapEmail(json, 'parsed'),
      notParsable: JsonParsers().parsingListId(json, 'notParsable'),
      notFound: JsonParsers().parsingListId(json, 'notFound'),
    );
  }
}
