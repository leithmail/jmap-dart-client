import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/methods/push/get_push_subscription_response.dart';

class GetPushSubscriptionMethod
    extends GetMethodNoNeedAccountId<GetPushSubscriptionResponse> {
  GetPushSubscriptionMethod() : super();

  @override
  MethodName get methodName => MethodName('PushSubscription/get');

  @override
  GetPushSubscriptionResponse responseFromJson(Map<String, dynamic> json) {
    return GetPushSubscriptionResponse.fromJson(json);
  }
}
