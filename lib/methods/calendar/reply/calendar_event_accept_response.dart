import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/api/method/response/calendar_event_reply_response.dart';
import 'package:jmap_dart_client/entities/calendar/properties/event_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/src/utils/json_parsers.dart';

class CalendarEventAcceptResponse extends CalendarEventReplyResponse {
  CalendarEventAcceptResponse(
    super.accountId,
    super.notFound, {
    this.accepted,
    this.notAccepted,
  });

  final List<EventId>? accepted;
  final Map<Id, SetError>? notAccepted;

  static CalendarEventAcceptResponse deserialize(Map<String, dynamic> json) {
    return CalendarEventAcceptResponse(
      JsonParsers().parsingAccountId(json),
      JsonParsers().parsingListId(json, 'notFound'),
      accepted: JsonParsers().parsingListEventId(json, 'accepted'),
      notAccepted: JsonParsers().parsingMapSetError(json, 'notAccepted'),
    );
  }
}
