import 'package:jmap_dart_client/entities/calendar/properties/event_id.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/errors/set_error.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/calendar/event_id_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';

class JsonParsers {
  const JsonParsers._();
  factory JsonParsers() => _instance;
  static const JsonParsers _instance = JsonParsers._();

  AccountId parsingAccountId(Map<String, dynamic> json) {
    return const AccountIdConverter().fromJson(json['accountId'] as String);
  }

  List<Id>? parsingListId(Map<String, dynamic> json, String key) {
    return (json[key] as List<dynamic>?)
        ?.map((value) => const IdConverter().fromJson(value as String))
        .toList();
  }

  List<EventId>? parsingListEventId(Map<String, dynamic> json, String key) {
    return (json[key] as List<dynamic>?)
        ?.map(
          (value) => const EventIdNullableConverter().fromJson(value as String),
        )
        .where((element) => element != null)
        .cast<EventId>()
        .toList();
  }

  Map<Id, SetError>? parsingMapSetError(Map<String, dynamic> json, String key) {
    return (json[key] as Map<String, dynamic>?)?.map(
      (key, value) =>
          MapEntry(const IdConverter().fromJson(key), SetError.fromJson(value)),
    );
  }

  Map<Id, Email>? parsingMapEmail(Map<String, dynamic> json, String key) {
    return (json[key] as Map<String, dynamic>?)?.map(
      (key, value) => MapEntry(
        const IdConverter().fromJson(key),
        Email.fromJson(value as Map<String, dynamic>),
      ),
    );
  }
}
