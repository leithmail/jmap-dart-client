import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/errors/jmap_exception.dart';

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
