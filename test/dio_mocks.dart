import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:jmap_dart_client/http/endpoint_http_client.dart';

class DioMockEndpointHttpClient extends EndpointHttpClient {
  DioMockEndpointHttpClient(Dio dio)
    : super(_DioInnerClient(dio), Uri.parse(''));
}

class _DioInnerClient extends http.BaseClient {
  final Dio _dio;

  _DioInnerClient(this._dio);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final body = await request.finalize().toBytes();

    final response = await _dio.requestUri<List<int>>(
      request.url,
      data: body.isNotEmpty ? body : null,
      options: Options(
        method: request.method,
        headers: request.headers,
        responseType: ResponseType.bytes,
      ),
    );

    return http.StreamedResponse(
      Stream.value(response.data ?? []),
      response.statusCode ?? 200,
      headers: response.headers.map.map(
        (key, values) => MapEntry(key, values.join(',')),
      ),
    );
  }
}
