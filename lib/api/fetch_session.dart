import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/api/errors/exceptions.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/capability_properties.dart';
import 'package:jmap_dart_client/entities/core/session.dart';

Future<Session> fetchSession(
  http.Client client,
  Uri url, {
  Map<
    CapabilityIdentifier,
    CapabilityProperties Function(Map<String, dynamic>)
  >?
  customCapabilityConverters,
}) async {
  try {
    final response = await client.get(url);
    if (response.statusCode == 401) throw JmapUnauthorizedException();
    if (response.statusCode >= 400) {
      throw JmapHttpException(response.statusCode);
    }
    return _extractData(
      response.body,
      customCapabilityConverters: customCapabilityConverters,
    );
  } on JmapException {
    rethrow;
  } catch (e) {
    throw JmapConnectionException(e);
  }
}

Session _extractData(
  String body, {
  Map<
    CapabilityIdentifier,
    CapabilityProperties Function(Map<String, dynamic>)
  >?
  customCapabilityConverters,
}) {
  try {
    return Session.fromJson(
      jsonDecode(body),
      customCapabilityConverters: customCapabilityConverters,
    );
  } catch (e) {
    throw JmapParseResponseException(message: e.toString());
  }
}
