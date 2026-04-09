import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/api/request/result_reference_tree.dart';

class _ExampleReference extends ResultReferenceTree {
  late final ResultReference first;
  late final ResultReference another;
  late final ResultReferenceArray<ResultReference> ids;

  _ExampleReference(super.resultReference) {
    first = $("first");
    another = $("another");
    ids = ResultReferenceArray($("ids"), (ref) => ref);
  }
}

class TestResultReferenceTree extends ResultReferenceTree {
  late final _ExampleReference example;
  late final ResultReferenceArray<_ExampleReference> list;
  late final ResultReferenceArray<ResultReference> simpleList;

  TestResultReferenceTree(super.resultReference) {
    example = _ExampleReference($("example"));
    list = ResultReferenceArray($("list"), _ExampleReference.new);
    simpleList = ResultReferenceArray($("simpleList"), (ref) => ref);
  }
}
