import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:json_annotation/json_annotation.dart';

class UnsignedIntConverter implements JsonConverter<UnsignedInt, int> {
  const UnsignedIntConverter();

  @override
  UnsignedInt fromJson(int json) {
    return UnsignedInt(json);
  }

  @override
  int toJson(UnsignedInt object) {
    return object.value.toInt();
  }
}
