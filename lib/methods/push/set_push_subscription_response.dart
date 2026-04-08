import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/api/method/response/set_response.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/push/push_subscription.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';

class SetPushSubscriptionResponse
    extends SetResponseNoAccount<PushSubscription> {
  SetPushSubscriptionResponse({
    Map<Id, PushSubscription>? created,
    Map<Id, PushSubscription?>? updated,
    Set<Id>? destroyed,
    Map<Id, SetError>? notCreated,
    Map<Id, SetError>? notUpdated,
    Map<Id, SetError>? notDestroyed,
  }) : super(
         created: created,
         updated: updated,
         destroyed: destroyed,
         notCreated: notCreated,
         notUpdated: notUpdated,
         notDestroyed: notDestroyed,
       );

  static SetPushSubscriptionResponse deserialize(Map<String, dynamic> json) {
    return SetPushSubscriptionResponse(
      created: (json['created'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          PushSubscription.fromJson(value as Map<String, dynamic>),
        ),
      ),
      updated: (json['updated'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          value != null
              ? PushSubscription.fromJson(value as Map<String, dynamic>)
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
