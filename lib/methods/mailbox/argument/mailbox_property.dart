import 'package:jmap_dart_client/api/method/argument/property.dart';

class MailboxProperty extends Property {
  static const id = MailboxProperty('id');
  static const name = MailboxProperty('name');
  static const parentId = MailboxProperty('parentId');
  static const role = MailboxProperty('role');
  static const sortOrder = MailboxProperty('sortOrder');
  static const totalEmails = MailboxProperty('totalEmails');
  static const unreadEmails = MailboxProperty('unreadEmails');
  static const totalThreads = MailboxProperty('totalThreads');
  static const unreadThreads = MailboxProperty('unreadThreads');
  static const myRights = MailboxProperty('myRights');
  static const isSubscribed = MailboxProperty('isSubscribed');
  static const namespace = MailboxProperty('namespace');
  static const rights = MailboxProperty('rights');
  const MailboxProperty(super.value);

  factory MailboxProperty.fromJson(String value) => MailboxProperty(value);
}
