import 'package:jmap_dart_client/errors/jmap_exception.dart';
import 'package:jmap_dart_client/errors/jmap_request_exception.dart';
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

    test('toString contains class name and key fields', () {
      final result = JmapRequestException(
        unknownCapability,
        detail: 'capability not supported',
        message: 'rejected',
      ).toString();
      expect(result, contains('JmapRequestException'));
      expect(result, contains(unknownCapability));
      expect(result, contains('capability not supported'));
      expect(result, contains('rejected'));
    });
  });
}
