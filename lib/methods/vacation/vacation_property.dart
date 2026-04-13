import 'package:jmap_dart_client/api/method/argument/property.dart';

class VacationProperty extends Property {
  static const id = VacationProperty('id');
  static const isEnabled = VacationProperty('isEnabled');
  static const fromDate = VacationProperty('fromDate');
  static const toDate = VacationProperty('toDate');
  static const subject = VacationProperty('subject');
  static const textBody = VacationProperty('textBody');
  static const htmlBody = VacationProperty('htmlBody');
  const VacationProperty(super.value);
}
