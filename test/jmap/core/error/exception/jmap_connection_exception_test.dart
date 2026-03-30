import 'dart:io';

import 'package:jmap_dart_client/jmap/core/error/exception/jmap_connection_exception.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_exception.dart';
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

    test('equal when same cause and message', () {
      const cause = SocketException('refused');
      expect(
        JmapConnectionException(cause, message: 'msg'),
        equals(JmapConnectionException(cause, message: 'msg')),
      );
    });

    test('not equal when different cause', () {
      expect(
        JmapConnectionException(const SocketException('a')),
        isNot(equals(JmapConnectionException(const SocketException('b')))),
      );
    });

    test('toString contains class name and cause', () {
      const cause = SocketException('refused');
      final result = JmapConnectionException(cause).toString();
      expect(result, contains('JmapConnectionException'));
    });
  });
}
