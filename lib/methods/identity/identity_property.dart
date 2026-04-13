import 'package:jmap_dart_client/api/api.dart';

class IdentityProperty extends Property {
  static const id = IdentityProperty('id');
  static const description = IdentityProperty('description');
  static const name = IdentityProperty('name');
  static const email = IdentityProperty('email');
  static const bcc = IdentityProperty('bcc');
  static const replyTo = IdentityProperty('replyTo');
  static const textSignature = IdentityProperty('textSignature');
  static const htmlSignature = IdentityProperty('htmlSignature');
  static const mayDelete = IdentityProperty('mayDelete');
  static const sortOrder = IdentityProperty('sortOrder');

  const IdentityProperty(super.value);
}
