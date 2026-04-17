import 'package:jmap_dart_client/api/method/response/changes_response.dart';
import 'package:jmap_dart_client/entities/email/email.dart';

class ChangesEmailResponse extends ChangesResponse<Email> {
  ChangesEmailResponse({
    required super.accountId,
    required super.oldState,
    required super.newState,
    required super.created,
    required super.updated,
    required super.destroyed,
    required super.hasMoreChanges,
  });

  factory ChangesEmailResponse.fromJson(Map<String, dynamic> json) {
    final parsed = ChangesResponse.parseJson<Email>(json);
    return ChangesEmailResponse(
      accountId: parsed.accountId,
      oldState: parsed.oldState,
      newState: parsed.newState,
      created: parsed.created,
      updated: parsed.updated,
      destroyed: parsed.destroyed,
      hasMoreChanges: parsed.hasMoreChanges,
    );
  }
}
