import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';

class SendMethodPropertiesConverter {
  MapEntry<String, dynamic> fromMapIdToJson(Id id, dynamic object) {
    return MapEntry(const IdConverter().toJson(id), object);
  }
}
