import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/api/response/response_object.dart';

class RequestInvocation<R extends MethodResponse> {
  final MethodName methodName;
  final Arguments<R> arguments;
  final MethodCallId methodCallId;

  RequestInvocation(this.methodName, this.arguments, this.methodCallId);

  ResultReference createResultReference(ReferencePath path) {
    return ResultReference(methodCallId, arguments.value.methodName, path);
  }

  R parse(ResponseObject response) {
    return response.parse<R>(
      methodCallId,
      arguments.value.deserializeResponse,
      methodName: methodName,
    );
  }
}

class MethodName with EquatableMixin {
  final String value;

  MethodName(this.value);

  @override
  List<Object> get props => [value];
}

class Arguments<R extends MethodResponse> {
  final Method<R> value;

  Arguments(this.value);
}

class MethodCallId with EquatableMixin {
  final String value;

  MethodCallId(this.value);

  @override
  List<Object> get props => [value];
}
