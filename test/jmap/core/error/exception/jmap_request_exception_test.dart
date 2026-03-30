import 'package:jmap_dart_client/jmap/core/error/exception/jmap_exception.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_request_exception.dart';
import 'package:test/test.dart';

void main() {
  group('JmapRequestException', () {
    const unknownCapability = 'urn:ietf:params:jmap:error:unknownCapability';

    test('is an Exception', () {
      expect(JmapRequestException(unknownCapability), isA<Exception>());
    });

    test('is a JmapException', () {
      expect(JmapRequestException(unknownCapability), isA<JmapException>());
    });

    test('stores type', () {
      expect(
        JmapRequestException(unknownCapability).type,
        equals(unknownCapability),
      );
    });

    test('stores detail', () {
      expect(
        JmapRequestException(
          unknownCapability,
          detail: 'capability not supported',
        ).detail,
        equals('capability not supported'),
      );
    });

    test('detail defaults to null', () {
      expect(JmapRequestException(unknownCapability).detail, isNull);
    });

    test('stores message', () {
      expect(
        JmapRequestException(unknownCapability, message: 'rejected').message,
        equals('rejected'),
      );
    });

    test('equal when same type, detail, and message', () {
      expect(
        JmapRequestException(
          unknownCapability,
          detail: 'cap not supported',
          message: 'rejected',
        ),
        equals(
          JmapRequestException(
            unknownCapability,
            detail: 'cap not supported',
            message: 'rejected',
          ),
        ),
      );
    });

    test('not equal when different type', () {
      expect(
        JmapRequestException('urn:ietf:params:jmap:error:notJSON'),
        isNot(equals(JmapRequestException(unknownCapability))),
      );
    });

    test('toString contains class name and type', () {
      final result = JmapRequestException(unknownCapability).toString();
      expect(result, contains('JmapRequestException'));
      expect(result, contains(unknownCapability));
    });
  });
}
