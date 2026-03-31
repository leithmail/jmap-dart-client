import 'package:jmap_dart_client/errors/jmap_exception.dart';

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
