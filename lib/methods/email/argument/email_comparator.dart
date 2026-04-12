import 'package:jmap_dart_client/api/method/argument/comparator.dart';

enum EmailSortProperty implements SortProperty {
  receivedAt(),
  sentAt(),
  size(),
  subject(),
  from(),
  to(),
  hasAttachment(),
  id();

  // ignore: unused_element_parameter
  const EmailSortProperty([this._value]);

  final String? _value;

  @override
  String get value => _value ?? name;
}

class EmailComparator extends Comparator<EmailSortProperty> {
  EmailComparator(super.property, {super.isAscending = true});
}
