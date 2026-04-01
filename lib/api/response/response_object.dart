import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/api/response/response_invocation.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/src/converters/response_invocation_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_object.g.dart';

@StateConverter()
@ResponseInvocationConverter()
@JsonSerializable()
class ResponseObject with EquatableMixin {
  final List<ResponseInvocation> methodResponses;
  final State sessionState;

  ResponseObject(this.methodResponses, this.sessionState);

  factory ResponseObject.fromJson(Map<String, dynamic> json) =>
      _$ResponseObjectFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseObjectToJson(this);

  @override
  List<Object?> get props => [methodResponses, sessionState];
}
