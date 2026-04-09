import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/api/errors/error_method_response.dart';
import 'package:jmap_dart_client/api/errors/error_type.dart';
import 'package:jmap_dart_client/api/errors/exceptions.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/api/request/result_reference_tree.dart';
import 'package:jmap_dart_client/api/response/response.dart';
import 'package:jmap_dart_client/api/response/response_invocation.dart';

class RequestInvocation<
  R extends MethodResponse,
  F extends ResultReferenceTree
> {
  final Method<R, F> method;
  final MethodCallId methodCallId;

  RequestInvocation(this.method, this.methodCallId);

  ResultReference createResultReference(ReferencePath path) {
    return ResultReference(
      resultOf: methodCallId,
      name: method.methodName(),
      path: path,
    );
  }

  R parseResponse(Response response) {
    final matchedResponse = response.methodResponses.firstWhere(
      (method) =>
          method.methodCallId == methodCallId &&
          _validMethodResponseName(method, method.methodName),
      orElse: () =>
          throw JmapParseResponseException(methodCallId: methodCallId),
    );

    if (matchedResponse.methodName == ErrorMethodResponse.errorMethodName) {
      final errorResponse = _parsingErrorMethodResponse(
        matchedResponse.arguments.value,
      );
      throw JmapMethodErrorException(errorResponse);
    }

    return method.responseFromJson(matchedResponse.arguments.value);
  }

  F resultReferenceTree() => method.resultReferenceTree(methodCallId);

  static bool _validMethodResponseName(
    ResponseInvocation responseInvocation,
    MethodName methodName,
  ) {
    return responseInvocation.methodName == methodName ||
        responseInvocation.methodName == ErrorMethodResponse.errorMethodName;
  }

  static ErrorMethodResponse _parsingErrorMethodResponse(
    Map<String, dynamic> errorResponse,
  ) {
    try {
      final description = errorResponse["description"];
      final errorType = ErrorType(errorResponse["type"]);
      if (errorType == ErrorMethodResponse.accountNotFound) {
        return AccountNotFoundMethodResponse(description: description);
      } else if (errorType == ErrorMethodResponse.accountNotSupportedByMethod) {
        return AccountNotSupportedByMethod(description: description);
      } else if (errorType == ErrorMethodResponse.accountReadOnly) {
        return AccountReadOnly(description: description);
      } else if (errorType == ErrorMethodResponse.forbidden) {
        return ForbiddenMethodResponse(description: description);
      } else if (errorType == ErrorMethodResponse.invalidArguments) {
        return InvalidArgumentsMethodResponse(description: description);
      } else if (errorType == ErrorMethodResponse.invalidResultReference) {
        return InvalidResultReferenceMethodResponse(description: description);
      } else if (errorType == ErrorMethodResponse.serverPartialFail) {
        return ServerPartialFailMethodResponse(description: description);
      } else if (errorType == ErrorMethodResponse.serverUnavailable) {
        return ServerUnavailableMethodResponse(description: description);
      } else if (errorType == ErrorMethodResponse.unknownMethod) {
        return UnknownMethodResponse(description: description);
      } else if (errorType == ErrorMethodResponse.serverFail) {
        return ServerFailMethodResponse(description: description);
      } else if (errorType == ErrorMethodResponse.cannotCalculateChanges) {
        return CannotCalculateChangesMethodResponse(description: description);
      } else {
        return UndefinedErrorMethodResponse(
          errorType,
          description: description,
        );
      }
    } catch (e) {
      developer.log("_parsingErrorMethodResponse(): Exception $e");
      return ServerFailMethodResponse();
    }
  }
}

class MethodCallId with EquatableMixin {
  final String value;

  MethodCallId(this.value);

  @override
  List<Object> get props => [value];
}
