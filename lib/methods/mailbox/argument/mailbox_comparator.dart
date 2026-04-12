import 'package:jmap_dart_client/api/method/argument/comparator.dart';

class MailboxSortProperty implements SortProperty {
  const MailboxSortProperty(this._value);

  final String _value;

  @override
  String get value => _value;
}

class MailboxComparator extends Comparator<MailboxSortProperty> {
  MailboxComparator(super.property, {super.isAscending = true});
}
