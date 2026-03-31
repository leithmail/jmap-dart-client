import 'package:jmap_dart_client/errors/jmap_exception.dart';

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
