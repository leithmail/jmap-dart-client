import 'package:jmap_dart_client/jmap/core/error/error_method_response.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_method_error_exception.dart';
import 'package:jmap_dart_client/jmap/core/error/exception/jmap_parse_response_exception.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/response/response_invocation.dart';
import 'package:jmap_dart_client/jmap/core/response/response_object.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:test/test.dart';

void main() {
  group('ResponseObject.parse() exception behaviour', () {
    group(
      'no matching methodCallId (TDD-red: currently throws StateError)',
      () {
        test(
          'throws JmapParseResponseException with the requested methodCallId',
          () {
            // arrange
            final invocation = ResponseInvocation(
              MethodName('Email/get'),
              ResponseArguments({'list': []}),
              MethodCallId('c1'),
            );
            final responseObject = ResponseObject([invocation], State('s1'));

            // act + assert
            expect(
              () => responseObject.parse<ErrorMethodResponse>(
                MethodCallId('c99'),
                (_) => ServerFailMethodResponse(),
              ),
              throwsA(
                isA<JmapParseResponseException>().having(
                  (e) => e.methodCallId?.value,
                  'methodCallId.value',
                  equals('c99'),
                ),
              ),
            );
          },
        );
      },
    );

    group('method error response (regression)', () {
      test('throws JmapMethodErrorException when server returns an error', () {
        // arrange
        final errorInvocation = ResponseInvocation(
          ErrorMethodResponse.errorMethodName,
          ResponseArguments({'type': 'serverFail', 'description': null}),
          MethodCallId('c1'),
        );
        final responseObject = ResponseObject([errorInvocation], State('s1'));

        // act + assert
        expect(
          () => responseObject.parse<ErrorMethodResponse>(
            MethodCallId('c1'),
            (_) => ServerFailMethodResponse(),
          ),
          throwsA(isA<JmapMethodErrorException>()),
        );
      });
    });
  });
}
