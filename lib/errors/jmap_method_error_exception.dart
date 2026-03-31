import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/errors/jmap_exception.dart';

class JmapMethodErrorException extends JmapException {
  final MethodResponse errorResponse;

  JmapMethodErrorException(this.errorResponse) : super();

  @override
  String toString() {
    return '$runtimeType(errorResponse: $errorResponse)';
  }
}
