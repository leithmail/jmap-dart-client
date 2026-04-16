import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/src/utils/utils.dart';

import 'method/method.dart';
import 'request/request.dart';
import 'request/request_invocation.dart';

class RequestBuilder {
  static const String _methodCallIdPrefix = 'c';
  final List<RequestInvocation> _invocations = [];
  final Set<CapabilityIdentifier> _capabilities = {};
  final List<MethodCallId> _methodCallIds = [];

  RequestInvocation<R, Q>
  addInvocation<R extends MethodResponse, Q extends ResultReference>(
    Method<R, Q> method, {
    MethodCallId? methodCallId,
    bool withRequiredCapabilities = true,
  }) {
    final callId = methodCallId ?? _generateMethodCallId();
    final RequestInvocation<R, Q> invocation = RequestInvocation<R, Q>(
      method: method,
      methodCallId: callId,
    );
    _addMethod(callId, invocation);
    if (withRequiredCapabilities) {
      addUsings(method.requiredCapabilities);
    }
    return invocation;
  }

  void addUsings(List<CapabilityIdentifier> capabilityIdentifiers) {
    _capabilities.addAll(capabilityIdentifiers);
  }

  Request build() {
    return Request(using: _capabilities.toList(), methodCalls: _invocations);
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
