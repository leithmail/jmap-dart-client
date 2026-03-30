import 'package:jmap_dart_client/jmap/core/error/exception/jmap_exception.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';

class JmapParseResponseException extends JmapException {
  final MethodCallId? methodCallId;

  JmapParseResponseException({this.methodCallId, String? message})
    : super(message: message);

  @override
  List<Object?> get props => [methodCallId, message];
}
