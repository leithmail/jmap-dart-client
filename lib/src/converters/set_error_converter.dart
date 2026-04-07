import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:json_annotation/json_annotation.dart';

class SetErrorConverter
    extends JsonConverter<Map<Id, SetError>, Map<String, dynamic>> {
  const SetErrorConverter();

  MapEntry<Id, SetError> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(Id(key), SetError.fromJson(value));
    } else {
      return MapEntry(Id(key), value);
    }
  }

  @override
  Map<Id, SetError> fromJson(Map<String, dynamic> json) {
    return json.map(parseEntry);
  }

  @override
  Map<String, dynamic> toJson(Map<Id, SetError> object) {
    return object.map((key, value) => MapEntry(key.value, value.toJson()));
  }
}
