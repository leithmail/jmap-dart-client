import 'package:http/http.dart' as http;

/// An [http.Client] that overrides the request URI to a fixed endpoint and adds optional headers.
class EndpointHttpClient extends http.BaseClient {
  final http.Client _client;
  final Uri _endpoint;
  final Map<String, String>? _headers;

  EndpointHttpClient(
    this._client,
    this._endpoint, {
    Map<String, String>? headers,
  }) : _headers = headers;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final overridden = http.Request(request.method, _endpoint)
      ..headers.addAll(_headers ?? {})
      ..headers.addAll(request.headers)
      ..bodyBytes = (request as http.Request).bodyBytes;

    return _client.send(overridden);
  }
}
