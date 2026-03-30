import 'package:jmap_dart_client/jmap/core/error/exception/jmap_exception.dart';

class JmapHttpException extends JmapException {
  final int statusCode;

  JmapHttpException(this.statusCode, {String? message})
    : super(message: message);

  @override
  List<Object?> get props => [statusCode, message];
}

class JmapUnauthorizedException extends JmapHttpException {
  JmapUnauthorizedException({String? message}) : super(401, message: message);

  @override
  List<Object?> get props => [statusCode, message];
}
