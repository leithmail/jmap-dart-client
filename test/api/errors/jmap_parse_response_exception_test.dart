import 'package:jmap_dart_client/api/errors/exceptions.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:test/test.dart';

void main() {
  group('JmapParseResponseException', () {
    test('is an Exception', () {
      expect(JmapParseResponseException(), isA<Exception>());
    });

    test('is a JmapException', () {
      expect(JmapParseResponseException(), isA<JmapException>());
    });

    group('with a specific methodCallId', () {
      test('stores methodCallId', () {
        final callId = MethodCallId('c1');
        final exception = JmapParseResponseException(methodCallId: callId);
        expect(exception.methodCallId, equals(callId));
      });
    });

    group('envelope-level failure (null methodCallId)', () {
      test('methodCallId is null', () {
        expect(
          JmapParseResponseException(message: 'malformed').methodCallId,
          isNull,
        );
      });
    });

    test('toString contains class name and methodCallId value', () {
      final result = JmapParseResponseException(
        methodCallId: MethodCallId('c1'),
        message: 'not found',
      ).toString();
      expect(result, contains('JmapParseResponseException'));
      expect(result, contains('c1'));
      expect(result, contains('not found'));
    });

    test(
      'toString with null message contains methodCallId without message',
      () {
        final result = JmapParseResponseException(
          methodCallId: MethodCallId('c2'),
        ).toString();
        expect(result, contains('JmapParseResponseException'));
        expect(result, contains('c2'));
        expect(result, isNot(contains('message:')));
      },
    );
  });
}
