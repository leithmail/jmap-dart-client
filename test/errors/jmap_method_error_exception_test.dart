import 'package:jmap_dart_client/errors/error_method_response.dart';
import 'package:jmap_dart_client/errors/jmap_exception.dart';
import 'package:jmap_dart_client/errors/jmap_method_error_exception.dart';
import 'package:test/test.dart';

void main() {
  group('JmapMethodErrorException', () {
    test('is an Exception', () {
      expect(
        JmapMethodErrorException(ServerFailMethodResponse()),
        isA<Exception>(),
      );
    });

    test('is a JmapException', () {
      expect(
        JmapMethodErrorException(ServerFailMethodResponse()),
        isA<JmapException>(),
      );
    });

    test('stores errorResponse', () {
      final response = ServerFailMethodResponse(description: 'internal error');
      final exception = JmapMethodErrorException(response);
      expect(exception.errorResponse, same(response));
    });

    test('toString contains class name', () {
      final result = JmapMethodErrorException(
        ServerFailMethodResponse(),
      ).toString();
      expect(result, contains('JmapMethodErrorException'));
      expect(result, contains('errorResponse:'));
    });
  });
}
