import 'package:jmap_dart_client/jmap/core/error/exception/jmap_exception.dart';
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';

class JmapMethodErrorException extends JmapException {
  final MethodResponse errorResponse;

  JmapMethodErrorException(this.errorResponse) : super();

  @override
  List<Object?> get props => [errorResponse];
}
