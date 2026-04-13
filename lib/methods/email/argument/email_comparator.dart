import 'package:jmap_dart_client/api/method/argument/comparator.dart';

class EmailSortProperty extends SortProperty {
  static const subject = EmailSortProperty('subject');
  static const from = EmailSortProperty('from');
  static const to = EmailSortProperty('to');
  static const receivedAt = EmailSortProperty('receivedAt');
  static const sentAt = EmailSortProperty('sentAt');
  static const size = EmailSortProperty('size');
  static const hasAttachment = EmailSortProperty('hasAttachment');
  static const id = EmailSortProperty('id');

  const EmailSortProperty(super.value);
}

class EmailComparator extends Comparator<EmailSortProperty> {
  EmailComparator(super.property, {super.isAscending = true});
}
