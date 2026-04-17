import 'package:jmap_dart_client/api/method/response/changes_response.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/methods/mailbox/argument/mailbox_property.dart';

class ChangesMailboxResponse extends ChangesResponse<Mailbox> {
  final List<MailboxProperty>? updatedProperties;

  ChangesMailboxResponse({
    required super.accountId,
    required super.oldState,
    required super.newState,
    required super.hasMoreChanges,
    required super.created,
    required super.updated,
    required super.destroyed,
    required this.updatedProperties,
  });

  factory ChangesMailboxResponse.fromJson(Map<String, dynamic> json) {
    final parsed = ChangesResponse.parseJson<Mailbox>(json);
    return ChangesMailboxResponse(
      accountId: parsed.accountId,
      oldState: parsed.oldState,
      newState: parsed.newState,
      hasMoreChanges: parsed.hasMoreChanges,
      created: parsed.created,
      updated: parsed.updated,
      destroyed: parsed.destroyed,
      updatedProperties: json['updatedProperties'] != null
          ? List<String>.from(
              json['updatedProperties']!,
            ).map((e) => MailboxProperty(e)).toList()
          : null,
    );
  }
}
