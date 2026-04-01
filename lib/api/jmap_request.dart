import 'package:built_collection/built_collection.dart';
import 'package:jmap_dart_client/src/utils/utils.dart';

import '../entities/capability/capability_identifier.dart';
import 'method/method.dart';
import 'request/request_invocation.dart';
import 'request/request_object.dart';

class JmapRequestBuilder {
  static const String methodCallIdPrefix = 'c';
  late BuiltMap<MethodCallId, RequestInvocation> _invocations;
  final SetBuilder<CapabilityIdentifier> _capabilitiesBuilder = SetBuilder();

  JmapRequestBuilder() {
    _invocations = BuiltMap();
  }

  RequestInvocation invocation(
    Method method, {
    MethodCallId? methodCallId,
    bool withRequiredCapabilities = true,
  }) {
    final callId = methodCallId ?? generateMethodCallId();
    final RequestInvocation invocation = RequestInvocation(
      method.methodName,
      Arguments(method),
      callId,
    );
    addMethod(callId, invocation);
    if (withRequiredCapabilities) {
      usings(method.requiredCapabilities);
    }
    return invocation;
  }

  void usings(Set<CapabilityIdentifier> capabilityIdentifiers) {
    _capabilitiesBuilder.addAll(capabilityIdentifiers);
  }

  RequestObject build() {
    return (RequestObject.builder()
          ..usings(_capabilitiesBuilder.build().asSet())
          ..methodCalls(_invocations.values.toList()))
        .build();
  }

  MethodCallId generateMethodCallId() {
    return positiveIntegers
        .map((item) => MethodCallId(methodCallIdPrefix + item.toString()))
        .firstWhere((callId) => !_invocations.keys.contains(callId));
  }

  void addMethod(MethodCallId callId, RequestInvocation requestInvocation) {
    _invocations =
        (_invocations.toBuilder()..addAll({callId: requestInvocation})).build();
  }
}
