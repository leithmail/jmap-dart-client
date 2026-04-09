import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/api/request/result_reference_tree.dart';

class _ExampleReference extends ResultReferenceTree {
  late final ResultReference first;
  late final ResultReference another;

  _ExampleReference(super.resultReference) {
    first = $("first");
    another = $("another");
  }
}

class TestResultReferenceTree extends ResultReferenceTree {
  late final _ExampleReference example;

  TestResultReferenceTree(super.resultReference) {
    example = _ExampleReference($("example"));
  }
}
