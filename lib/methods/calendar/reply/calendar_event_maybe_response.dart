import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/api/method/response/calendar_event_reply_response.dart';
import 'package:jmap_dart_client/entities/calendar/properties/event_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/src/utils/json_parsers.dart';

class CalendarEventMaybeResponse extends CalendarEventReplyResponse {
  CalendarEventMaybeResponse(
    super.accountId,
    super.notFound, {
    this.maybe,
    this.notMaybe,
  });

  final List<EventId>? maybe;
  final Map<Id, SetError>? notMaybe;

  factory CalendarEventMaybeResponse.fromJson(Map<String, dynamic> json) {
    return CalendarEventMaybeResponse(
      JsonParsers().parsingAccountId(json),
      JsonParsers().parsingListId(json, 'notFound'),
      maybe: JsonParsers().parsingListEventId(json, 'maybe'),
      notMaybe: JsonParsers().parsingMapSetError(json, 'notMaybe'),
    );
  }
}
