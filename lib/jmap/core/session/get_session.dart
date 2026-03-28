import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/http/converter/capabilities_converter.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:jmap_dart_client/jmap/core/session/session.dart';

class GetSession {
  final http.Client _httpClient;
  final CapabilitiesConverter _capabilitiesConverter;

  GetSession(this._httpClient, this._capabilitiesConverter);

  Future<Session> execute() async {
    final response = await _httpClient.get(Uri.parse('/.well-known/jmap'));
    return extractData(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Session extractData(Map<String, dynamic> body) {
    return Session.fromJson(body, converter: _capabilitiesConverter);
  }
}

class GetSessionBuilder {
  final http.Client _httpClient;
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
