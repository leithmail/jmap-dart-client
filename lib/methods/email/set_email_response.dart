import 'package:jmap_dart_client/api/method/response/set_response.dart';
import 'package:jmap_dart_client/entities/email/email.dart';

class SetEmailResponse extends SetResponse<Email> {
  SetEmailResponse({
    required super.accountId,
    required super.oldState,
    required super.newState,
    required super.created,
    required super.updated,
    required super.destroyed,
    required super.notCreated,
    required super.notUpdated,
    required super.notDestroyed,
  });

  factory SetEmailResponse.fromJson(Map<String, dynamic> json) {
    final response = SetResponse.parseJson(
      json,
      (value) => Email.fromJson(value),
    );
    return SetEmailResponse(
      accountId: response.accountId,
      oldState: response.oldState,
      newState: response.newState,
      created: response.created,
      updated: response.updated,
      destroyed: response.destroyed,
      notCreated: response.notCreated,
      notUpdated: response.notUpdated,
      notDestroyed: response.notDestroyed,
    );
  }
}
