import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/id.dart';

abstract class CalendarEventReplyResponse extends ResponseRequiringAccountId {
  CalendarEventReplyResponse(super.accountId, this.notFound);

  final List<Id>? notFound;
}
