import 'dart:convert';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:jmap_dart_client/api/endpoint_http_client.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/api/response/response_object.dart';
import 'package:jmap_dart_client/errors/exceptions.dart';
import 'package:jmap_dart_client/src/utils/utils.dart';
import 'package:quiver/check.dart';

import '../entities/capability/capability_identifier.dart';
import 'method/method.dart';
import 'request/request_invocation.dart';
import 'request/request_object.dart';

class JmapRequest {
  final EndpointHttpClient _httpClient;
  final BuiltSet<CapabilityIdentifier> _capabilities;
  final BuiltMap<MethodCallId, RequestInvocation> _invocations;

  JmapRequest(this._httpClient, this._capabilities, this._invocations);

  RequestObject? _requestObject;
  RequestObject? get requestObject => _requestObject;

  Future<ResponseObject> execute() async {
    _requestObject =
        (RequestObject.builder()
              ..usings(_capabilities.asSet())
              ..methodCalls(_invocations.values.toList()))
            .build();

    try {
      final response = await _httpClient.post(
        Uri.parse(
          '',
        ), // this uri is overridden by EndpointHttpClient, so it can be empty
        body: jsonEncode(_requestObject?.toJson()),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (response.statusCode == 401) throw JmapUnauthorizedException();
      if (response.statusCode >= 400) {
        throw JmapHttpException(response.statusCode);
      }
      return _extractData(response.body);
    } on JmapException {
      rethrow;
    } catch (e) {
      throw JmapConnectionException(e);
    }
  }

  ResponseObject _extractData(String body) {
    try {
      return ResponseObject.fromJson(jsonDecode(body) as Map<String, dynamic>);
    } catch (e) {
      throw JmapParseResponseException(message: e.toString());
    }
  }
}

class JmapRequestBuilder {
  final EndpointHttpClient _httpClient;
  final ProcessingInvocation _processingInvocation;
  final SetBuilder<CapabilityIdentifier> _capabilitiesBuilder = SetBuilder();

  JmapRequestBuilder(this._httpClient, this._processingInvocation);

  RequestInvocation invocation(
    Method method, {
    MethodCallId? methodCallId,
    bool withRequiredCapabilities = true,
  }) {
    final callId = methodCallId ?? _processingInvocation.generateMethodCallId();
    final RequestInvocation invocation = RequestInvocation(
      method.methodName,
      Arguments(method),
      callId,
    );
    _processingInvocation.addMethod(callId, invocation);
    if (withRequiredCapabilities) {
      usings(method.requiredCapabilities);
    }
    return invocation;
  }

  void usings(Set<CapabilityIdentifier> capabilityIdentifiers) {
    _capabilitiesBuilder.addAll(capabilityIdentifiers);
  }

  JmapRequest build() {
    return JmapRequest(
      _httpClient,
      _capabilitiesBuilder.build(),
      _processingInvocation._invocations,
    );
  }
}

class ProcessingInvocation {
  static const String methodCallIdPrefix = 'c';
  late BuiltMap<MethodCallId, RequestInvocation> _invocations;

  ProcessingInvocation() {
    _invocations = BuiltMap();
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

  ResultReference createResultReference(
    MethodCallId methodCallId,
    ReferencePath path,
  ) {
    checkArgument(
      _invocations.containsKey(methodCallId),
      message: 'no matched method call id',
    );
    return _invocations[methodCallId]!.createResultReference(path);
  }
}
