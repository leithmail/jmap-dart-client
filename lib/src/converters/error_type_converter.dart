import 'package:jmap_dart_client/api/errors/error_type.dart';
import 'package:json_annotation/json_annotation.dart';

class ErrorTypeConverter implements JsonConverter<ErrorType, String> {
  const ErrorTypeConverter();

  @override
  ErrorType fromJson(String json) => ErrorType(json);

  @override
  String toJson(ErrorType object) => object.value;
}
