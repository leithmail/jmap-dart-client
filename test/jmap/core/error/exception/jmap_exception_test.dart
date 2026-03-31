import 'package:jmap_dart_client/jmap/core/error/exception/jmap_exception.dart';
import 'package:test/test.dart';

class _ConcreteJmapException extends JmapException {
  _ConcreteJmapException({super.message});
}

void main() {
  group('JmapException', () {
    test('is an Exception', () {
      expect(_ConcreteJmapException(), isA<Exception>());
    });

    test('is a JmapException', () {
      expect(_ConcreteJmapException(), isA<JmapException>());
    });

    test('stores message', () {
      final exception = _ConcreteJmapException(message: 'something went wrong');
      expect(exception.message, equals('something went wrong'));
    });

    test('message defaults to null', () {
      expect(_ConcreteJmapException().message, isNull);
    });

    test('toString contains class name and message', () {
      final result = _ConcreteJmapException(message: 'oops').toString();
      expect(result, contains('_ConcreteJmapException'));
      expect(result, contains('oops'));
    });

    test('toString with null message only contains class name', () {
      final result = _ConcreteJmapException().toString();
      expect(result, equals('_ConcreteJmapException'));
    });
  });
}
