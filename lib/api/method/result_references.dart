import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';

class ResultReferences {
  final MethodCallId resultOf;
  final MethodName name;
  ResultReferences({required this.resultOf, required this.name});
}
