import 'package:jmap_dart_client/errors/jmap_exception.dart';

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
