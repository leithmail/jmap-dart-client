import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/response/response_invocation.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/errors/error_method_response.dart';
import 'package:jmap_dart_client/errors/error_type.dart';
import 'package:jmap_dart_client/errors/jmap_method_error_exception.dart';
import 'package:jmap_dart_client/errors/jmap_parse_response_exception.dart';
import 'package:jmap_dart_client/src/converters/response_invocation_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_object.g.dart';

@StateConverter()
@ResponseInvocationConverter()
@JsonSerializable()
class ResponseObject with EquatableMixin {
  final List<ResponseInvocation> methodResponses;
  final State sessionState;

  ResponseObject(this.methodResponses, this.sessionState);

  factory ResponseObject.fromJson(Map<String, dynamic> json) =>
      _$ResponseObjectFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseObjectToJson(this);

  T parse<T extends MethodResponse>(
    MethodCallId methodCallId,
    T Function(Map<String, dynamic> o) fromJson, {
    MethodName? methodName,
  }) {
    final matchedResponse = methodResponses.firstWhere(
      (method) => methodName == null
          ? method.methodCallId == methodCallId
          : (method.methodCallId == methodCallId &&
                _validMethodResponseName(method, methodName)),
      orElse: () =>
          throw JmapParseResponseException(methodCallId: methodCallId),
    );

    if (matchedResponse.methodName == ErrorMethodResponse.errorMethodName) {
      final errorResponse = _parsingErrorMethodResponse(
        matchedResponse.arguments.value,
      );
      throw JmapMethodErrorException(errorResponse);
    }

    return fromJson(matchedResponse.arguments.value);
  }

  bool _validMethodResponseName(
    ResponseInvocation responseInvocation,
    MethodName methodName,
  ) {
    return responseInvocation.methodName == methodName ||
        responseInvocation.methodName == ErrorMethodResponse.errorMethodName;
  }

  ErrorMethodResponse _parsingErrorMethodResponse(
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

  @override
  List<Object?> get props => [methodResponses, sessionState];
}
