import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/identity/identity.dart';
import 'package:json_annotation/json_annotation.dart';

class IdentityIdConverter implements JsonConverter<IdentityId, String> {
  const IdentityIdConverter();

  @override
  IdentityId fromJson(String json) => IdentityId(Id(json));

  @override
  String toJson(IdentityId object) => object.id.value;
}
