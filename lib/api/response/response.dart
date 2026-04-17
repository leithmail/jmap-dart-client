import 'package:jmap_dart_client/api/response/response_invocation.dart';
import 'package:jmap_dart_client/entities/entities.dart';
import 'package:jmap_dart_client/src/converters/response_invocation_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@ResponseInvocationConverter()
@JsonSerializable(createToJson: false)
class Response {
  final List<ResponseInvocation> methodResponses;
  final Session sessionState;

  Response(this.methodResponses, this.sessionState);

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
}
