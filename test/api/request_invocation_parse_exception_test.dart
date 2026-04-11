import 'package:jmap_dart_client/api/api.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:test/test.dart';

void main() {
  group('RequestInvocation.parseResponse() exception behaviour', () {
    group('no matching methodCallId', () {
      test(
        'throws JmapParseResponseException with the requested methodCallId',
        () {
          // arrange
          final requestInvocation =
              RequestInvocation<ErrorMethodResponse, ResultReference>(
                _FakeErrorMethod(),
                MethodCallId('c99'),
              );
          final responseInvocation = ResponseInvocation(
            MethodName('Email/get'),
            ResponseArguments({'list': []}),
            MethodCallId('c1'),
          );
          final responseObject = Response([responseInvocation], State('s1'));

          // act + assert
          expect(
            () => requestInvocation.parseResponse(responseObject),
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
    });

    group('method error response (regression)', () {
      test('throws JmapMethodErrorException when server returns an error', () {
        // arrange
        final requestInvocation =
            RequestInvocation<ErrorMethodResponse, ResultReference>(
              _FakeErrorMethod(),
              MethodCallId('c1'),
            );
        final errorInvocation = ResponseInvocation(
          ErrorMethodResponse.errorMethodName,
          ResponseArguments({'type': 'serverFail', 'description': null}),
          MethodCallId('c1'),
        );
        final responseObject = Response([errorInvocation], State('s1'));

        // act + assert
        expect(
          () => requestInvocation.parseResponse(responseObject),
          throwsA(isA<JmapMethodErrorException>()),
        );
      });
    });
  });
}

class _FakeErrorMethod extends Method<ErrorMethodResponse, ResultReference> {
  @override
  MethodName methodName() => MethodName('Email/get');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {};

  @override
  ErrorMethodResponse responseFromJson(Map<String, dynamic> json) {
    return ServerFailMethodResponse();
  }

  @override
  ResultReference resultReference(MethodCallId resultOf) =>
      resultReferenceDefault(resultOf);
}
