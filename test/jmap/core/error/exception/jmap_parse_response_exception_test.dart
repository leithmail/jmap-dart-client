import 'package:jmap_dart_client/jmap/core/error/exception/jmap_exception.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_parse_response_exception.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
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

      test('equal when same methodCallId and message', () {
        final callId = MethodCallId('c1');
        expect(
          JmapParseResponseException(
            methodCallId: callId,
            message: 'not found',
          ),
          equals(
            JmapParseResponseException(
              methodCallId: callId,
              message: 'not found',
            ),
          ),
        );
      });

      test('not equal when different methodCallId', () {
        expect(
          JmapParseResponseException(methodCallId: MethodCallId('c1')),
          isNot(
            equals(
              JmapParseResponseException(methodCallId: MethodCallId('c2')),
            ),
          ),
        );
      });
    });

    group('envelope-level failure (null methodCallId)', () {
      test('methodCallId is null', () {
        expect(
          JmapParseResponseException(message: 'malformed').methodCallId,
          isNull,
        );
      });

      test('equal when both have null methodCallId and same message', () {
        expect(
          JmapParseResponseException(message: 'err'),
          equals(JmapParseResponseException(message: 'err')),
        );
      });
    });

    test('toString contains class name', () {
      final result = JmapParseResponseException(
        methodCallId: MethodCallId('c1'),
      ).toString();
      expect(result, contains('JmapParseResponseException'));
    });
  });
}
