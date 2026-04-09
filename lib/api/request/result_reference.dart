import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/src/converters/method_call_id_converter.dart';
import 'package:jmap_dart_client/src/converters/method_name_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result_reference.g.dart';

@MethodNameConverter()
@MethodCallIdConverter()
@JsonSerializable(createFactory: false)
class ResultReference {
  final MethodCallId resultOf;
  final MethodName name;
  final ReferencePath path;

  ResultReference({
    required this.resultOf,
    required this.name,
    required this.path,
  });

  Map<String, dynamic> toJson() => _$ResultReferenceToJson(this);
}
