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

    test('equal when same statusCode and message', () {
      expect(
        JmapHttpException(500, message: 'err'),
        equals(JmapHttpException(500, message: 'err')),
      );
    });

    test('not equal when different statusCode', () {
      expect(JmapHttpException(404), isNot(equals(JmapHttpException(500))));
    });

    test('toString contains class name and statusCode', () {
      final result = JmapHttpException(503).toString();
      expect(result, contains('JmapHttpException'));
      expect(result, contains('503'));
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

    test('equal when same message', () {
      expect(
        JmapUnauthorizedException(message: 'expired'),
        equals(JmapUnauthorizedException(message: 'expired')),
      );
    });

    test('not equal when different message', () {
      expect(
        JmapUnauthorizedException(message: 'a'),
        isNot(equals(JmapUnauthorizedException(message: 'b'))),
      );
    });

    test('toString contains class name', () {
      final result = JmapUnauthorizedException().toString();
      expect(result, contains('JmapUnauthorizedException'));
    });
  });
}
