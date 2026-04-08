import 'package:jmap_dart_client/api/method/response/parse_response.dart';
import 'package:jmap_dart_client/entities/calendar/calendar_event.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';

class CalendarEventParseResponse extends ParseResponse<List<CalendarEvent>> {
  CalendarEventParseResponse(
    AccountId accountId, {
    Map<Id, List<CalendarEvent>>? parsed,
    List<Id>? notParsable,
    List<Id>? notFound,
  }) : super(
         accountId,
         parsed: parsed,
         notParsable: notParsable,
         notFound: notFound,
       );

  static CalendarEventParseResponse deserialize(Map<String, dynamic> json) {
    return CalendarEventParseResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      parsed: (json['parsed'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          (value as List<dynamic>)
              .map((e) => CalendarEvent.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
      notParsable: (json['notParsable'] as List<dynamic>?)
          ?.map((value) => const IdConverter().fromJson(value as String))
          .toList(),
      notFound: (json['notFound'] as List<dynamic>?)
          ?.map((value) => const IdConverter().fromJson(value as String))
          .toList(),
    );
  }
}
