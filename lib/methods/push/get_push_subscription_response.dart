import 'package:jmap_dart_client/api/method/response/get_response.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/push/push_subscription.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_push_subscription_response.g.dart';

@IdConverter()
@JsonSerializable(createToJson: false)
class GetPushSubscriptionResponse
    extends GetResponseNoAccountId<PushSubscription> {
  GetPushSubscriptionResponse(List<PushSubscription> list, List<Id>? notFound)
    : super(list, notFound);

  factory GetPushSubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPushSubscriptionResponseFromJson(json);
}
