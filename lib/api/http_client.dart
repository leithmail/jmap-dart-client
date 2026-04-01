import 'package:http/http.dart' as http;

/// An [http.Client] convenience wrapper that adds optional headers to all requests.
class HttpClient extends http.BaseClient {
  final http.Client _client;
  final Map<String, String>? _headers;

  HttpClient(this._client, {Map<String, String>? headers}) : _headers = headers;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final overridden = http.Request(request.method, request.url)
      ..headers.addAll(_headers ?? {})
      ..headers.addAll(request.headers)
      ..bodyBytes = (request as http.Request).bodyBytes;

    return _client.send(overridden);
  }
}
