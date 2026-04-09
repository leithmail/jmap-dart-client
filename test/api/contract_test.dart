import 'package:jmap_dart_client/jmap_dart_client.dart';
import 'package:test/test.dart';

import 'test_result_reference_tree.dart';

class TestMethodResponse extends MethodResponse {
  final int value;

  TestMethodResponse({required this.value});
}

class TestMethod extends Method<TestMethodResponse, TestResultReferenceTree> {
  @override
  MethodName methodName() => MethodName('test');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {};

  @override
  TestMethodResponse responseFromJson(Map<String, dynamic> json) {
    return TestMethodResponse(value: 1);
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  TestResultReferenceTree resultReferenceTree(MethodCallId resultOf) =>
      TestResultReferenceTree(
        ResultReference(
          resultOf: resultOf,
          name: methodName(),
          path: ReferencePath.root,
        ),
      );
}

void main() {
  test('contract', () {
    final requestBuilder = RequestBuilder();
    final testMethod = TestMethod();
    final testInvocation = requestBuilder.addInvocation(testMethod);
    testInvocation.resultReferenceTree().list.$ref;
    testInvocation.resultReferenceTree().list.$each.ids.$each;
    testInvocation.resultReferenceTree().simpleList.$ref;
    testInvocation.resultReferenceTree().simpleList.$each;

    expect(true, isTrue);
  });
}
