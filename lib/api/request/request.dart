import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/api/errors/exceptions.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/response/response.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/id.dart';

class Request {
  final List<CapabilityIdentifier> using;
  final List<RequestInvocation> methodCalls;
  final Map<CreationId, Id>? createdIds;

  Request({
    required List<CapabilityIdentifier> using,
    required List<RequestInvocation> methodCalls,
    Map<CreationId, Id>? createdIds,
  }) : using = List.unmodifiable(using),
       methodCalls = List.unmodifiable(methodCalls),
       createdIds = createdIds == null ? null : Map.unmodifiable(createdIds);

  Map<String, dynamic> toJson() => {
    'using': using.map((capability) => capability.toJson()).toList(),
    'methodCalls': methodCalls.map((call) => call.toJson()).toList(),
    if (createdIds != null)
      'createdIds': createdIds!.map(
        (key, value) => MapEntry(key.toJson(), value.toJson()),
      ),
  };

  Future<Response> execute(http.Client client, Uri url) async {
    final String encodedRequest;
    // coverage:ignore-start
    try {
      encodedRequest = jsonEncode(toJson());
    } catch (e) {
      // This should never happen since toJson should only produce JSON-serializable data, but we catch it just in case.
      throw Exception('Failed to encode request: $e');
    }
    // coverage:ignore-end
    try {
      final response = await client.post(
        url,
        body: encodedRequest,
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

  Response _extractData(String body) {
    try {
      return Response.fromJson(jsonDecode(body));
    } catch (e) {
      throw JmapParseResponseException(message: e.toString());
    }
  }
}
