import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';

abstract class JmapException implements Exception {
  final String? message;

  JmapException({this.message});

  @override
  String toString() {
    return message == null ? '$runtimeType' : '$runtimeType(message: $message)';
  }
}

class JmapConnectionException extends JmapException {
  final Object cause;

  JmapConnectionException(this.cause, {String? message})
    : super(message: message);

  @override
  String toString() {
    return message == null
        ? '$runtimeType(cause: $cause)'
        : '$runtimeType(cause: $cause, message: $message)';
  }
}

class JmapHttpException extends JmapException {
  final int statusCode;

  JmapHttpException(this.statusCode, {String? message})
    : super(message: message);

  @override
  String toString() {
    return message == null
        ? '$runtimeType(statusCode: $statusCode)'
        : '$runtimeType(statusCode: $statusCode, message: $message)';
  }
}

class JmapUnauthorizedException extends JmapHttpException {
  JmapUnauthorizedException({String? message}) : super(401, message: message);
}

class JmapMethodErrorException extends JmapException {
  final MethodResponse errorResponse;

  JmapMethodErrorException(this.errorResponse) : super();

  @override
  String toString() {
    return '$runtimeType(errorResponse: $errorResponse)';
  }
}

class JmapParseResponseException extends JmapException {
  final MethodCallId? methodCallId;

  JmapParseResponseException({this.methodCallId, String? message})
    : super(message: message);

  @override
  String toString() {
    final methodCallIdText = methodCallId?.value;
    return message == null
        ? '$runtimeType(methodCallId: $methodCallIdText)'
        : '$runtimeType(methodCallId: $methodCallIdText, message: $message)';
  }
}

class JmapRequestException extends JmapException {
  final String type;
  final String? detail;

  JmapRequestException(this.type, {this.detail, String? message})
    : super(message: message);

  @override
  String toString() {
    return '$runtimeType(type: $type, detail: $detail, message: $message)';
  }
}
