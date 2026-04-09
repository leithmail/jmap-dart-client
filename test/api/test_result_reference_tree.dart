import 'package:jmap_dart_client/api/request/result_reference.dart';

class _BlalaRef extends ResultReferenceTree {
  final String value = "bla";
  final String another = "bla";

  _BlalaRef(super.resultReference);
}

class TestResultReferenceTree extends ResultReferenceTree {
  late final _BlalaRef blabla;

  TestResultReferenceTree(super.resultReference) {
    blabla = _BlalaRef(child("blabla"));
  }
}
