import 'package:jmap_dart_client/api/method/argument/property.dart';

class ThreadProperty extends Property {
  static const id = ThreadProperty('id');
  static const emailIds = ThreadProperty('emailIds');
  const ThreadProperty(super.value);
}
