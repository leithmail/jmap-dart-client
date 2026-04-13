import 'package:jmap_dart_client/api/method/argument/property.dart';

class CalendarEventProperty extends Property {
  static const uid = CalendarEventProperty('uid');
  static const eventId = CalendarEventProperty('eventId');
  static const title = CalendarEventProperty('title');
  static const description = CalendarEventProperty('description');
  static const startDate = CalendarEventProperty('startDate');
  static const endDate = CalendarEventProperty('endDate');
  static const startUtcDate = CalendarEventProperty('startUtcDate');
  static const endUtcDate = CalendarEventProperty('endUtcDate');
  static const duration = CalendarEventProperty('duration');
  static const timeZone = CalendarEventProperty('timeZone');
  static const location = CalendarEventProperty('location');
  static const method = CalendarEventProperty('method');
  static const sequence = CalendarEventProperty('sequence');
  static const privacy = CalendarEventProperty('privacy');
  static const priority = CalendarEventProperty('priority');
  static const freeBusyStatus = CalendarEventProperty('freeBusyStatus');
  static const status = CalendarEventProperty('status');
  static const organizer = CalendarEventProperty('organizer');
  static const participants = CalendarEventProperty('participants');
  static const extensionFields = CalendarEventProperty('extensionFields');
  static const recurrenceRules = CalendarEventProperty('recurrenceRules');
  static const excludedCalendarEvents = CalendarEventProperty(
    'excludedCalendarEvents',
  );
  const CalendarEventProperty(super.value);
}
