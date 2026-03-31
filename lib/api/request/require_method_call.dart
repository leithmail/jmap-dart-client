import 'package:built_collection/built_collection.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/method/method.dart';

mixin RequireMethodCall<T extends Method> {
  final ListBuilder<RequestInvocation> invocationsBuilder = ListBuilder();

  void methodCalls(List<RequestInvocation> newInvocations) {
    invocationsBuilder.addAll(newInvocations);
  }
}
