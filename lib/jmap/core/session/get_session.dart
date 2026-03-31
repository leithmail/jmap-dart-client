import 'dart:convert';

import 'package:jmap_dart_client/http/converter/capabilities_converter.dart';
import 'package:jmap_dart_client/http/endpoint_http_client.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_connection_exception.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_exception.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_http_exception.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_parse_response_exception.dart';
import 'package:jmap_dart_client/jmap/core/session/session.dart';

class GetSession {
  final EndpointHttpClient _httpClient;
  final CapabilitiesConverter _capabilitiesConverter;

  GetSession(this._httpClient, this._capabilitiesConverter);

  Future<Session> execute() async {
    try {
      final response = await _httpClient.get(
        Uri.parse(''),
      ); // this uri is overridden by EndpointHttpClient, so it can be empty
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

  Session _extractData(String body) {
    try {
      return Session.fromJson(
        jsonDecode(body) as Map<String, dynamic>,
        converter: _capabilitiesConverter,
      );
    } catch (e) {
      throw JmapParseResponseException(message: e.toString());
    }
  }
}

class GetSessionBuilder {
  final EndpointHttpClient _httpClient;
  final CapabilitiesConverter _capabilitiesConverter = CapabilitiesConverter();

  GetSessionBuilder(this._httpClient);

  void registerCapabilityConverter(
    Map<
      CapabilityIdentifier,
      CapabilityProperties Function(Map<String, dynamic>)
    >
    converters,
  ) {
    _capabilitiesConverter.addConverters(converters);
    _capabilitiesConverter.build();
  }

  GetSession build() {
    return GetSession(_httpClient, _capabilitiesConverter);
  }
}
