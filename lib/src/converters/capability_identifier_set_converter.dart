import 'package:jmap_dart_client/entities/capability/capability_identifier.dart';
import 'package:json_annotation/json_annotation.dart';

class CapabilityIdentifierSetConverter
    implements JsonConverter<Set<CapabilityIdentifier>, List<String>> {
  const CapabilityIdentifierSetConverter();

  @override
  Set<CapabilityIdentifier> fromJson(List<String> json) =>
      json.map((String json) => CapabilityIdentifier(Uri.parse(json))).toSet();

  @override
  List<String> toJson(Set<CapabilityIdentifier> object) =>
      object
          .map((CapabilityIdentifier object) => object.value.toString())
          .toList()
        ..sort(); // sort to ensure consistent order for testing and readability
}
