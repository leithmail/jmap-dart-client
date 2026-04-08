import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/api/method/response/calendar_event_reply_response.dart';
import 'package:jmap_dart_client/entities/calendar/properties/event_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/src/utils/json_parsers.dart';

class CalendarEventRejectResponse extends CalendarEventReplyResponse {
  CalendarEventRejectResponse(
    super.accountId,
    super.notFound, {
    this.rejected,
    this.notRejected,
  });

  final List<EventId>? rejected;
  final Map<Id, SetError>? notRejected;

  factory CalendarEventRejectResponse.fromJson(Map<String, dynamic> json) {
    return CalendarEventRejectResponse(
      JsonParsers().parsingAccountId(json),
      JsonParsers().parsingListId(json, 'notFound'),
      rejected: JsonParsers().parsingListEventId(json, 'rejected'),
      notRejected: JsonParsers().parsingMapSetError(json, 'notRejected'),
    );
  }
}
