import 'package:jmap_dart_client/api/method/argument/property.dart';

class EmailProperty extends Property {
  static const id = EmailProperty('id');
  static const blobId = EmailProperty('blobId');
  static const threadId = EmailProperty('threadId');
  static const mailboxIds = EmailProperty('mailboxIds');
  static const keywords = EmailProperty('keywords');
  static const size = EmailProperty('size');
  static const receivedAt = EmailProperty('receivedAt');
  static const messageId = EmailProperty('messageId');
  static const inReplyTo = EmailProperty('inReplyTo');
  static const references = EmailProperty('references');
  static const sender = EmailProperty('sender');
  static const from = EmailProperty('from');
  static const to = EmailProperty('to');
  static const cc = EmailProperty('cc');
  static const bcc = EmailProperty('bcc');
  static const replyTo = EmailProperty('replyTo');
  static const subject = EmailProperty('subject');
  static const sentAt = EmailProperty('sentAt');
  static const hasAttachment = EmailProperty('hasAttachment');
  static const preview = EmailProperty('preview');
  static const bodyValues = EmailProperty('bodyValues');
  static const textBody = EmailProperty('textBody');
  static const htmlBody = EmailProperty('htmlBody');
  static const attachments = EmailProperty('attachments');
  const EmailProperty(super.value);
}
