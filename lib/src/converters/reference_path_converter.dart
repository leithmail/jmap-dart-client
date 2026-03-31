import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:json_annotation/json_annotation.dart';

class ReferencePathConverter implements JsonConverter<ReferencePath, String> {
  const ReferencePathConverter();

  @override
  ReferencePath fromJson(String json) => ReferencePath(json);

  @override
  String toJson(ReferencePath object) => object.value;
}
