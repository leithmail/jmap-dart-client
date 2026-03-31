abstract class JmapException implements Exception {
  final String? message;

  JmapException({this.message});

  @override
  String toString() {
    return message == null ? '$runtimeType' : '$runtimeType(message: $message)';
  }
}
