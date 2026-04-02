import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/response/response.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/errors/exceptions.dart';
import 'package:jmap_dart_client/src/converters/capability_identifier_set_converter.dart';
import 'package:jmap_dart_client/src/converters/request_invocation_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@CapabilityIdentifierSetConverter()
@RequestInvocationConverter()
@JsonSerializable()
class Request with EquatableMixin {
  final Set<CapabilityIdentifier> using;
  final List<RequestInvocation> methodCalls;

  Request(Set<CapabilityIdentifier> using, List<RequestInvocation> methodCalls)
    : using = Set.unmodifiable(using),
      methodCalls = List.unmodifiable(methodCalls);

  @override
  @JsonKey(includeToJson: false)
  List<Object> get props => [using, methodCalls];

  Map<String, dynamic> toJson() => _$RequestToJson(this);

  Future<Response> execute(http.Client client, Uri url) async {
    try {
      final response = await client.post(
        url,
        body: jsonEncode(toJson()),
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
