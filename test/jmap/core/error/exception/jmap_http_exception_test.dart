import 'package:jmap_dart_client/jmap/core/error/exception/jmap_exception.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_http_exception.dart';
import 'package:test/test.dart';

void main() {
  group('JmapHttpException', () {
    test('is an Exception', () {
      expect(JmapHttpException(503), isA<Exception>());
    });

    test('is a JmapException', () {
      expect(JmapHttpException(503), isA<JmapException>());
    });

    test('stores statusCode', () {
      expect(JmapHttpException(503).statusCode, equals(503));
    });

    test('stores message', () {
      expect(
        JmapHttpException(503, message: 'unavailable').message,
        equals('unavailable'),
      );
    });

    test('message defaults to null', () {
      expect(JmapHttpException(404).message, isNull);
    });

    test('toString contains class name and statusCode', () {
      final result = JmapHttpException(503).toString();
      expect(result, contains('JmapHttpException'));
      expect(result, contains('503'));
    });

    test('toString contains message when provided', () {
      final result = JmapHttpException(503, message: 'unavailable').toString();
      expect(result, contains('unavailable'));
    });
  });

  group('JmapUnauthorizedException', () {
    test('is an Exception', () {
      expect(JmapUnauthorizedException(), isA<Exception>());
    });

    test('is a JmapException', () {
      expect(JmapUnauthorizedException(), isA<JmapException>());
    });

    test('is a JmapHttpException', () {
      expect(JmapUnauthorizedException(), isA<JmapHttpException>());
    });

    test('statusCode is 401', () {
      expect(JmapUnauthorizedException().statusCode, equals(401));
    });

    test('stores message', () {
      expect(
        JmapUnauthorizedException(message: 'token expired').message,
        equals('token expired'),
      );
    });

    test('toString contains class name', () {
      final result = JmapUnauthorizedException().toString();
      expect(result, contains('JmapUnauthorizedException'));
      expect(result, contains('401'));
    });

    test('toString contains message', () {
      final result = JmapUnauthorizedException(
        message: 'token expired',
      ).toString();
      expect(result, contains('token expired'));
    });
  });
}
