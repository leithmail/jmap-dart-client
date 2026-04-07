import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/src/utils/utils.dart';

import 'method/method.dart';
import 'request/request.dart';
import 'request/request_invocation.dart';

class RequestBuilder {
  static const String _methodCallIdPrefix = 'c';
  final List<RequestInvocation> _invocations = [];
  final Set<CapabilityIdentifier> _capabilities = {};
  final Set<MethodCallId> _methodCallIds = {};

  RequestInvocation<R> addInvocation<R extends MethodResponse>(
    Method<R> method, {
    MethodCallId? methodCallId,
    bool withRequiredCapabilities = true,
  }) {
    final callId = methodCallId ?? _generateMethodCallId();
    final RequestInvocation<R> invocation = RequestInvocation<R>(
      method,
      callId,
    );
    _addMethod(callId, invocation);
    if (withRequiredCapabilities) {
      addUsings(method.requiredCapabilities);
    }
    return invocation;
  }

  void addUsings(Set<CapabilityIdentifier> capabilityIdentifiers) {
    _capabilities.addAll(capabilityIdentifiers);
  }

  Request build() {
    return Request(_capabilities, _invocations);
  }

  MethodCallId _generateMethodCallId() {
    return positiveIntegers
        .map((item) => MethodCallId(_methodCallIdPrefix + item.toString()))
        .firstWhere((callId) => !_methodCallIds.contains(callId));
  }

  void _addMethod(MethodCallId callId, RequestInvocation requestInvocation) {
    _methodCallIds.add(callId);
    _invocations.add(requestInvocation);
  }
}
