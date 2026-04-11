import 'package:jmap_dart_client/entities/core/collation_identifier.dart';
import 'package:json_annotation/json_annotation.dart';

class CollationIdentifierConverter
    implements JsonConverter<CollationIdentifier, String> {
  const CollationIdentifierConverter();

  @override
  CollationIdentifier fromJson(String json) => CollationIdentifier(json);

  @override
  String toJson(CollationIdentifier object) => object.value;
}
