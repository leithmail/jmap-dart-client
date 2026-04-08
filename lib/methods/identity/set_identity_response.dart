import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/api/method/response/set_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/identity/identity.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/state_nullable_converter.dart';

class SetIdentityResponse extends SetResponse<Identity> {
  SetIdentityResponse(
    AccountId accountId, {
    State? newState,
    State? oldState,
    Map<Id, Identity>? created,
    Map<Id, Identity?>? updated,
    Set<Id>? destroyed,
    Map<Id, SetError>? notCreated,
    Map<Id, SetError>? notUpdated,
    Map<Id, SetError>? notDestroyed,
  }) : super(
         accountId,
         newState: newState,
         oldState: oldState,
         created: created,
         updated: updated,
         destroyed: destroyed,
         notCreated: notCreated,
         notUpdated: notUpdated,
         notDestroyed: notDestroyed,
       );

  static SetIdentityResponse deserialize(Map<String, dynamic> json) {
    return SetIdentityResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      newState: const StateNullableConverter().fromJson(
        json['newState'] as String?,
      ),
      oldState: const StateNullableConverter().fromJson(
        json['oldState'] as String?,
      ),
      created: (json['created'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          Identity.fromJson(value as Map<String, dynamic>),
        ),
      ),
      updated: (json['updated'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          value != null
              ? Identity.fromJson(value as Map<String, dynamic>)
              : null,
        ),
      ),
      destroyed: (json['destroyed'] as List<dynamic>?)
          ?.map((id) => const IdConverter().fromJson(id))
          .toSet(),
      notCreated: (json['notCreated'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          SetError.fromJson(value),
        ),
      ),
      notUpdated: (json['notUpdated'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          SetError.fromJson(value),
        ),
      ),
      notDestroyed: (json['notDestroyed'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          SetError.fromJson(value),
        ),
      ),
    );
  }
}
