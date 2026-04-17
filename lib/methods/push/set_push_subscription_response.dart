import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/push/push_subscription.dart';

class SetPushSubscriptionResponse extends MethodResponse {
  final Map<CreationId<PushSubscription>, PushSubscription>?
  creaPushSubscriptioned;
  final Map<Id<PushSubscription>, PushSubscription?>? updated;
  final List<Id<PushSubscription>>? destroyed;
  final Map<CreationId<PushSubscription>, SetError>? notCreated;
  final Map<Id<PushSubscription>, SetError>? notUpdated;
  final Map<Id<PushSubscription>, SetError>? notDestroyed;

  SetPushSubscriptionResponse({
    required this.creaPushSubscriptioned,
    required this.updated,
    required this.destroyed,
    required this.notCreated,
    required this.notUpdated,
    required this.notDestroyed,
  });

  factory SetPushSubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return SetPushSubscriptionResponse(
      creaPushSubscriptioned:
          (json['creaPushSubscriptioned'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
              CreationId<PushSubscription>(key),
              PushSubscription.fromJson(value),
            ),
          ),
      updated: (json['updated'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          Id<PushSubscription>(key),
          value != null ? PushSubscription.fromJson(value) : null,
        ),
      ),
      destroyed: (json['destroyed'] as List<dynamic>?)
          ?.map((e) => Id<PushSubscription>(e as String))
          .toList(),
      notCreated: (json['notCreated'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          CreationId<PushSubscription>(key),
          SetError.fromJson(value),
        ),
      ),
      notUpdated: (json['notUpdated'] as Map<String, dynamic>?)?.map(
        (key, value) =>
            MapEntry(Id<PushSubscription>(key), SetError.fromJson(value)),
      ),
      notDestroyed: (json['notDestroyed'] as Map<String, dynamic>?)?.map(
        (key, value) =>
            MapEntry(Id<PushSubscription>(key), SetError.fromJson(value)),
      ),
    );
  }
}
