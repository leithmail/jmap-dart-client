import 'package:jmap_dart_client/api/method/argument/sort/comparator_property.dart';
import 'package:json_annotation/json_annotation.dart';

class ComparatorPropertyConverter
    implements JsonConverter<ComparatorProperty, String> {
  const ComparatorPropertyConverter();

  @override
  ComparatorProperty fromJson(String json) => ComparatorProperty(json);

  @override
  String toJson(ComparatorProperty object) => object.value;
}
