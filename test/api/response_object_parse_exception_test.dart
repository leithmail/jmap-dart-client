import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/response/response_invocation.dart';
import 'package:jmap_dart_client/api/response/response_object.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/errors/error_method_response.dart';
import 'package:jmap_dart_client/errors/exceptions.dart';
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
