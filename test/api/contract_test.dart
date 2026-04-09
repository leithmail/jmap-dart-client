import 'package:jmap_dart_client/api/method/result_references.dart';
import 'package:jmap_dart_client/jmap_dart_client.dart';
import 'package:test/test.dart';

class TestResultReferences extends ResultReferences {
  final String blabla = "bla";

  TestResultReferences({required super.resultOf, required super.name});
}

class TestMethodResponse extends MethodResponse {
  final int value;

  TestMethodResponse({required this.value});
}

class TestMethod extends Method<TestMethodResponse, TestResultReferences> {
  @override
  MethodName get methodName => MethodName('test');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {};

  @override
  TestMethodResponse responseFromJson(Map<String, dynamic> json) {
    return TestMethodResponse(value: 1);
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  TestResultReferences resultReferences(MethodCallId resultOf) =>
      TestResultReferences(resultOf: resultOf, name: methodName);
}

void main() {
  test('contract', () {
    final requestBuilder = RequestBuilder();
    final testMethod = TestMethod();
    final testInvocation = requestBuilder.addInvocation(testMethod);
    testInvocation.resultReferences().blabla;

    expect(true, isTrue);
  });
}
