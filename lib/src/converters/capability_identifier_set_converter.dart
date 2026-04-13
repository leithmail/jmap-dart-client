import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:json_annotation/json_annotation.dart';

class CapabilityIdentifierSetConverter
    implements JsonConverter<List<CapabilityIdentifier>, List<String>> {
  const CapabilityIdentifierSetConverter();

  @override
  List<CapabilityIdentifier> fromJson(List<String> json) =>
      json.map((String json) => CapabilityIdentifier(Uri.parse(json))).toList();

  @override
  List<String> toJson(List<CapabilityIdentifier> object) {
    return object
        .map((CapabilityIdentifier object) => object.value.toString())
        .toList()
      ..sort(); // sort to ensure consistent order for testing and readability
  }
}
