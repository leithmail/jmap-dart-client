import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/utc_date.dart';
import 'package:jmap_dart_client/entities/email/email_address.dart';
import 'package:jmap_dart_client/entities/email/email_body_part.dart';
import 'package:jmap_dart_client/entities/email/email_body_value.dart';
import 'package:jmap_dart_client/entities/email/email_header.dart';
import 'package:jmap_dart_client/entities/email/email_keyword.dart';
import 'package:jmap_dart_client/entities/email/individual_header_identifier.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/entities/thread/thread.dart';
import 'package:jmap_dart_client/src/converters/individual_header_identifier_converter.dart';
import 'package:jmap_dart_client/src/converters/message_ids_header_value_nullable_converter.dart';

class Email with EquatableMixin {
  final EmailId? id;
  final BlobId? blobId;
  final ThreadId? threadId;
  final Map<MailboxId, bool>? mailboxIds;
  final Map<EmailKeyword, bool>? keywords;
  final int? size;
  final UTCDate? receivedAt;

  final List<EmailHeader>? headers;
  final MessageIdsHeaderValue? messageId;
  final MessageIdsHeaderValue? inReplyTo;
  final MessageIdsHeaderValue? references;
  final String? subject;
  final UTCDate? sentAt;
  final bool? hasAttachment;
  final String? preview;
  final List<EmailAddress>? sender;
  final List<EmailAddress>? from;
  final List<EmailAddress>? to;
  final List<EmailAddress>? cc;
  final List<EmailAddress>? bcc;
  final List<EmailAddress>? replyTo;
  final List<EmailBodyPart>? textBody;
  final List<EmailBodyPart>? htmlBody;
  final List<EmailBodyPart>? attachments;
  final EmailBodyPart? bodyStructure;
  final Map<EmailBodyPartId, EmailBodyValue>? bodyValues;
  final Map<IndividualHeaderIdentifier, String?>? headerUserAgent;
  final Map<IndividualHeaderIdentifier, String?>? headerMdn;
  final Map<IndividualHeaderIdentifier, String?>? headerReturnPath;
  final Map<IndividualHeaderIdentifier, String?>? headerCalendarEvent;
  final Map<IndividualHeaderIdentifier, String?>? sMimeStatusHeader;
  final Map<IndividualHeaderIdentifier, String?>? identityHeader;
  final Map<IndividualHeaderIdentifier, String?>? xPriorityHeader;
  final Map<IndividualHeaderIdentifier, String?>? importanceHeader;
  final Map<IndividualHeaderIdentifier, String?>? priorityHeader;
  final Map<IndividualHeaderIdentifier, String?>? listPostHeader;
  final Map<IndividualHeaderIdentifier, String?>? listUnsubscribeHeader;

  Email({
    this.id,
    this.blobId,
    this.threadId,
    this.mailboxIds,
    this.keywords,
    this.size,
    this.receivedAt,
    this.headers,
    this.messageId,
    this.inReplyTo,
    this.references,
    this.subject,
    this.sentAt,
    this.hasAttachment,
    this.preview,
    this.sender,
    this.from,
    this.to,
    this.cc,
    this.bcc,
    this.replyTo,
    this.textBody,
    this.htmlBody,
    this.attachments,
    this.bodyStructure,
    this.bodyValues,
    this.headerUserAgent,
    this.headerMdn,
    this.headerReturnPath,
    this.headerCalendarEvent,
    this.sMimeStatusHeader,
    this.identityHeader,
    this.xPriorityHeader,
    this.importanceHeader,
    this.priorityHeader,
    this.listPostHeader,
    this.listUnsubscribeHeader,
  });

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      id: json['id'] != null ? EmailId.fromJson(json['id'] as String) : null,
      blobId: json['blobId'] != null
          ? BlobId.fromJson(json['blobId'] as String)
          : null,
      threadId: json['threadId'] != null
          ? ThreadId.fromJson(json['threadId'] as String)
          : null,
      mailboxIds: (json['mailboxIds'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(MailboxId(key), value as bool),
      ),
      keywords: (json['keywords'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(EmailKeyword(key), value as bool),
      ),
      size: json['size'] as int?,
      receivedAt: json['receivedAt'] != null
          ? UTCDate.fromJson(json['receivedAt'] as String)
          : null,
      headers: (json['headers'] as List<dynamic>?)
          ?.map((json) => EmailHeader.fromJson(json))
          .toList(),
      messageId: const MessageIdsHeaderValueNullableConverter().fromJson(
        (json['messageId'] as List<dynamic>?),
      ),
      inReplyTo: const MessageIdsHeaderValueNullableConverter().fromJson(
        (json['inReplyTo'] as List<dynamic>?),
      ),
      references: const MessageIdsHeaderValueNullableConverter().fromJson(
        (json['references'] as List<dynamic>?),
      ),
      subject: json['subject'] as String?,
      sentAt: json['sentAt'] != null
          ? UTCDate.fromJson(json['sentAt'] as String)
          : null,
      hasAttachment: json['hasAttachment'] as bool?,
      preview: json['preview'] as String?,
      sender: (json['sender'] as List<dynamic>?)
          ?.map((json) => EmailAddress.fromJson(json))
          .toList(),
      from: (json['from'] as List<dynamic>?)
          ?.map((json) => EmailAddress.fromJson(json))
          .toList(),
      to: (json['to'] as List<dynamic>?)
          ?.map((json) => EmailAddress.fromJson(json))
          .toList(),
      cc: (json['cc'] as List<dynamic>?)
          ?.map((json) => EmailAddress.fromJson(json))
          .toList(),
      bcc: (json['bcc'] as List<dynamic>?)
          ?.map((json) => EmailAddress.fromJson(json))
          .toList(),
      replyTo: (json['replyTo'] as List<dynamic>?)
          ?.map((json) => EmailAddress.fromJson(json))
          .toList(),
      textBody: (json['textBody'] as List<dynamic>?)
          ?.map((json) => EmailBodyPart.fromJson(json))
          .toList(),
      htmlBody: (json['htmlBody'] as List<dynamic>?)
          ?.map((json) => EmailBodyPart.fromJson(json))
          .toList(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((json) => EmailBodyPart.fromJson(json))
          .toList(),
      bodyStructure: json['bodyStructure'] == null
          ? null
          : EmailBodyPart.fromJson(
              json['bodyStructure'] as Map<String, dynamic>,
            ),
      bodyValues: (json['bodyValues'] as Map<String, dynamic>?)?.map(
        (key, value) =>
            MapEntry(EmailBodyPartId(key), EmailBodyValue.fromJson(value)),
      ),
      headerUserAgent: IndividualHeaderIdentifierNullableConverter().parseEntry(
        IndividualHeaderIdentifier.headerUserAgent.value,
        json[IndividualHeaderIdentifier.headerUserAgent.value] as String?,
      ),
      headerMdn: IndividualHeaderIdentifierNullableConverter().parseEntry(
        IndividualHeaderIdentifier.headerMdn.value,
        json[IndividualHeaderIdentifier.headerMdn.value] as String?,
      ),
      headerReturnPath: IndividualHeaderIdentifierNullableConverter()
          .parseEntry(
            IndividualHeaderIdentifier.headerReturnPath.value,
            json[IndividualHeaderIdentifier.headerReturnPath.value] as String?,
          ),
      headerCalendarEvent: IndividualHeaderIdentifierNullableConverter()
          .parseEntry(
            IndividualHeaderIdentifier.headerCalendarEvent.value,
            json[IndividualHeaderIdentifier.headerCalendarEvent.value]
                as String?,
          ),
      sMimeStatusHeader: IndividualHeaderIdentifierNullableConverter()
          .parseEntry(
            IndividualHeaderIdentifier.sMimeStatusHeader.value,
            json[IndividualHeaderIdentifier.sMimeStatusHeader.value] as String?,
          ),
      identityHeader: IndividualHeaderIdentifierNullableConverter().parseEntry(
        IndividualHeaderIdentifier.identityHeader.value,
        json[IndividualHeaderIdentifier.identityHeader.value] as String?,
      ),
      xPriorityHeader: IndividualHeaderIdentifierNullableConverter().parseEntry(
        IndividualHeaderIdentifier.xPriorityHeader.value,
        json[IndividualHeaderIdentifier.xPriorityHeader.value] as String?,
      ),
      importanceHeader: IndividualHeaderIdentifierNullableConverter()
          .parseEntry(
            IndividualHeaderIdentifier.importanceHeader.value,
            json[IndividualHeaderIdentifier.importanceHeader.value] as String?,
          ),
      priorityHeader: IndividualHeaderIdentifierNullableConverter().parseEntry(
        IndividualHeaderIdentifier.priorityHeader.value,
        json[IndividualHeaderIdentifier.priorityHeader.value] as String?,
      ),
      listPostHeader: IndividualHeaderIdentifierNullableConverter().parseEntry(
        IndividualHeaderIdentifier.listPostHeader.value,
        json[IndividualHeaderIdentifier.listPostHeader.value] as String?,
      ),
      listUnsubscribeHeader: IndividualHeaderIdentifierNullableConverter()
          .parseEntry(
            IndividualHeaderIdentifier.listUnsubscribeHeader.value,
            json[IndividualHeaderIdentifier.listUnsubscribeHeader.value]
                as String?,
          ),
    );
  }

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('id', id?.toJson());
    writeNotNull('blobId', blobId?.toJson());
    writeNotNull('threadId', threadId?.toJson());
    writeNotNull(
      'mailboxIds',
      mailboxIds?.map((key, value) => MapEntry(key.value, value)),
    );
    writeNotNull(
      'keywords',
      keywords?.map((key, value) => MapEntry(key.value, value)),
    );
    writeNotNull('size', size);
    writeNotNull('receivedAt', receivedAt?.toJson());
    writeNotNull('headers', headers?.map((header) => header.toJson()).toList());
    writeNotNull(
      'messageId',
      const MessageIdsHeaderValueNullableConverter().toJson(messageId),
    );
    writeNotNull(
      'inReplyTo',
      const MessageIdsHeaderValueNullableConverter().toJson(inReplyTo),
    );
    writeNotNull(
      'references',
      const MessageIdsHeaderValueNullableConverter().toJson(references),
    );
    writeNotNull('subject', subject);
    writeNotNull('sentAt', sentAt?.toJson());
    writeNotNull('hasAttachment', hasAttachment);
    writeNotNull('preview', preview);
    writeNotNull('sender', sender?.map((sender) => sender.toJson()).toList());
    writeNotNull('from', from?.map((from) => from.toJson()).toList());
    writeNotNull('to', to?.map((to) => to.toJson()).toList());
    writeNotNull('cc', cc?.map((cc) => cc.toJson()).toList());
    writeNotNull('bcc', bcc?.map((bcc) => bcc.toJson()).toList());
    writeNotNull(
      'replyTo',
      replyTo?.map((replyTo) => replyTo.toJson()).toList(),
    );
    writeNotNull('textBody', textBody?.map((text) => text.toJson()).toList());
    writeNotNull('htmlBody', htmlBody?.map((html) => html.toJson()).toList());
    writeNotNull(
      'attachments',
      attachments?.map((attachment) => attachment.toJson()).toList(),
    );
    writeNotNull('bodyStructure', bodyStructure?.toJson());
    writeNotNull(
      'bodyValues',
      bodyValues?.map((key, value) => MapEntry(key.value, value.toJson())),
    );
    writeNotNull(
      IndividualHeaderIdentifier.headerUserAgent.value,
      IndividualHeaderIdentifierNullableConverter().toJson(
        headerUserAgent,
        IndividualHeaderIdentifier.headerUserAgent,
      ),
    );
    writeNotNull(
      IndividualHeaderIdentifier.headerMdn.value,
      IndividualHeaderIdentifierNullableConverter().toJson(
        headerMdn,
        IndividualHeaderIdentifier.headerMdn,
      ),
    );
    writeNotNull(
      IndividualHeaderIdentifier.headerReturnPath.value,
      IndividualHeaderIdentifierNullableConverter().toJson(
        headerReturnPath,
        IndividualHeaderIdentifier.headerReturnPath,
      ),
    );
    writeNotNull(
      IndividualHeaderIdentifier.headerCalendarEvent.value,
      IndividualHeaderIdentifierNullableConverter().toJson(
        headerCalendarEvent,
        IndividualHeaderIdentifier.headerCalendarEvent,
      ),
    );
    writeNotNull(
      IndividualHeaderIdentifier.sMimeStatusHeader.value,
      IndividualHeaderIdentifierNullableConverter().toJson(
        sMimeStatusHeader,
        IndividualHeaderIdentifier.sMimeStatusHeader,
      ),
    );
    writeNotNull(
      IndividualHeaderIdentifier.identityHeader.value,
      IndividualHeaderIdentifierNullableConverter().toJson(
        identityHeader,
        IndividualHeaderIdentifier.identityHeader,
      ),
    );
    writeNotNull(
      IndividualHeaderIdentifier.xPriorityHeader.value,
      IndividualHeaderIdentifierNullableConverter().toJson(
        xPriorityHeader,
        IndividualHeaderIdentifier.xPriorityHeader,
      ),
    );
    writeNotNull(
      IndividualHeaderIdentifier.importanceHeader.value,
      IndividualHeaderIdentifierNullableConverter().toJson(
        importanceHeader,
        IndividualHeaderIdentifier.importanceHeader,
      ),
    );
    writeNotNull(
      IndividualHeaderIdentifier.priorityHeader.value,
      IndividualHeaderIdentifierNullableConverter().toJson(
        priorityHeader,
        IndividualHeaderIdentifier.priorityHeader,
      ),
    );
    writeNotNull(
      IndividualHeaderIdentifier.listPostHeader.value,
      IndividualHeaderIdentifierNullableConverter().toJson(
        listPostHeader,
        IndividualHeaderIdentifier.listPostHeader,
      ),
    );
    writeNotNull(
      IndividualHeaderIdentifier.listUnsubscribeHeader.value,
      IndividualHeaderIdentifierNullableConverter().toJson(
        listUnsubscribeHeader,
        IndividualHeaderIdentifier.listUnsubscribeHeader,
      ),
    );
    return val;
  }

  @override
  List<Object?> get props => [
    id,
    blobId,
    threadId,
    mailboxIds,
    keywords,
    size,
    receivedAt,
    headers,
    messageId,
    inReplyTo,
    references,
    subject,
    sentAt,
    hasAttachment,
    preview,
    sender,
    from,
    to,
    cc,
    bcc,
    replyTo,
    textBody,
    htmlBody,
    attachments,
    bodyStructure,
    bodyValues,
    headerUserAgent,
    headerMdn,
    headerReturnPath,
    headerCalendarEvent,
    sMimeStatusHeader,
    identityHeader,
    xPriorityHeader,
    importanceHeader,
    priorityHeader,
    listPostHeader,
    listUnsubscribeHeader,
  ];
}

typedef EmailId = Id<Email>;
typedef EmailCreationId = CreationId<Email>;

class MessageIdsHeaderValue with EquatableMixin {
  final List<String> ids;

  MessageIdsHeaderValue(this.ids);

  @override
  List<Object?> get props => [ids];
}
