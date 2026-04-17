import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/email/email.dart';

class ParseEmailResponse extends MethodResponse {
  final AccountId accountId;
  final Map<Id<Email>, Email>? parsed;
  final List<Id<Email>>? notParsable;
  final List<Id<Email>>? notFound;

  factory ParseEmailResponse.fromJson(Map<String, dynamic> json) {
    return ParseEmailResponse(
      accountId: AccountId(json['accountId'] as String),
      parsed: (json['parsed'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          Id<Email>.fromJson(key),
          Email.fromJson(value as Map<String, dynamic>),
        ),
      ),
      notParsable: (json['notParsable'] as List<String>?)
          ?.map((value) => Id<Email>.fromJson(value))
          .toList(),
      notFound: (json['notFound'] as List<String>?)
          ?.map((value) => Id<Email>.fromJson(value))
          .toList(),
    );
  }

  ParseEmailResponse({
    required this.accountId,
    required this.parsed,
    required this.notParsable,
    required this.notFound,
  });
}
