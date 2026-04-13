import 'package:jmap_dart_client/api/method/argument/property.dart';

class PushSubscriptionProperty extends Property {
  static const id = PushSubscriptionProperty('id');
  static const deviceClientId = PushSubscriptionProperty('deviceClientId');
  static const url = PushSubscriptionProperty('url');
  static const keys = PushSubscriptionProperty('keys');
  static const verificationCode = PushSubscriptionProperty('verificationCode');
  static const expires = PushSubscriptionProperty('expires');
  static const types = PushSubscriptionProperty('types');

  const PushSubscriptionProperty(super.value);
}
