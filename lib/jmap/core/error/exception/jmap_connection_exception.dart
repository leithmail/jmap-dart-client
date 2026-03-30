import 'package:jmap_dart_client/jmap/core/error/exception/jmap_exception.dart';

class JmapConnectionException extends JmapException {
  final Object cause;

  JmapConnectionException(this.cause, {String? message})
    : super(message: message);

  @override
  List<Object?> get props => [cause, message];
}
