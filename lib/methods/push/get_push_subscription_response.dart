import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_push_subscription_response.g.dart';

@JsonSerializable(createToJson: false)
class GetPushSubscriptionResponse extends MethodResponse {
  final List<PushSubscription> list;
  final List<Id<PushSubscription>>? notFound;

  GetPushSubscriptionResponse({required this.list, required this.notFound});

  factory GetPushSubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPushSubscriptionResponseFromJson(json);
}
