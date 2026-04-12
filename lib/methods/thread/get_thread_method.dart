import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/thread/get_thread_response.dart';

class GetThreadMethod extends GetMethod<GetThreadResponse> {
  GetThreadMethod(super.accountId);

  @override
  MethodName get methodName => MethodName('Thread/get');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapMail,
  ];

  @override
  GetThreadResponse responseFromJson(Map<String, dynamic> json) {
    return GetThreadResponse.fromJson(json);
  }
}
