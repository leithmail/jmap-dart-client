import 'dart:io';

import 'package:jmap_dart_client/errors/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('JmapConnectionException', () {
    test('is an Exception', () {
      expect(
        JmapConnectionException(const SocketException('refused')),
        isA<Exception>(),
      );
    });

    test('is a JmapException', () {
      expect(
        JmapConnectionException(const SocketException('refused')),
        isA<JmapException>(),
      );
    });

    test('stores cause', () {
      const cause = SocketException('Connection refused');
      final exception = JmapConnectionException(cause);
      expect(exception.cause, same(cause));
    });

    test('stores message', () {
      final exception = JmapConnectionException(
        const SocketException('refused'),
        message: 'could not connect',
      );
      expect(exception.message, equals('could not connect'));
    });

    test('message defaults to null', () {
      expect(
        JmapConnectionException(const SocketException('refused')).message,
        isNull,
      );
    });

    test('toString contains class name and cause', () {
      const cause = SocketException('refused');
      final result = JmapConnectionException(cause).toString();
      expect(result, contains('JmapConnectionException'));
      expect(result, contains('cause:'));
    });

    test('toString with message contains message', () {
      final result = JmapConnectionException(
        const SocketException('refused'),
        message: 'could not connect',
      ).toString();
      expect(result, contains('could not connect'));
    });
  });
}
