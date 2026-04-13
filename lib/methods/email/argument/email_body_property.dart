import 'package:jmap_dart_client/api/method/argument/property.dart';

class EmailBodyProperty extends Property {
  static const partId = EmailBodyProperty('partId');
  static const blobId = EmailBodyProperty('blobId');
  static const size = EmailBodyProperty('size');
  static const name = EmailBodyProperty('name');
  static const type = EmailBodyProperty('type');
  static const charset = EmailBodyProperty('charset');
  static const disposition = EmailBodyProperty('disposition');
  static const cid = EmailBodyProperty('cid');
  static const language = EmailBodyProperty('language');
  static const location = EmailBodyProperty('location');

  const EmailBodyProperty(super.value);
}
