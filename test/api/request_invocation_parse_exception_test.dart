import 'package:jmap_dart_client/api/errors/error_method_response.dart';
import 'package:jmap_dart_client/api/errors/exceptions.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/response/response.dart';
import 'package:jmap_dart_client/api/response/response_invocation.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:test/test.dart';

void main() {
  group('RequestInvocation.parse() exception behaviour', () {
    group('no matching methodCallId', () {
      test(
        'throws JmapParseResponseException with the requested methodCallId',
        () {
          // arrange
          final requestInvocation = RequestInvocation<ErrorMethodResponse>(
            MethodName('Email/get'),
            Arguments(_FakeErrorMethod()),
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
            () => requestInvocation.parse(responseObject),
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
        final requestInvocation = RequestInvocation<ErrorMethodResponse>(
          MethodName('Email/get'),
          Arguments(_FakeErrorMethod()),
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
          () => requestInvocation.parse(responseObject),
          throwsA(isA<JmapMethodErrorException>()),
        );
      });
    });
  });
}

class _FakeErrorMethod extends Method<ErrorMethodResponse> {
  @override
  MethodName get methodName => MethodName('Email/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {};

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{};

  @override
  ErrorMethodResponse deserializeResponse(Map<String, dynamic> json) {
    return ServerFailMethodResponse();
  }
}
