import 'package:jmap_dart_client/entities/email/email_body_part.dart';
import 'package:jmap_dart_client/entities/email/email_body_value.dart';
import 'package:jmap_dart_client/src/converters/part_id_converter.dart';

class EmailBodyValueConverter {
  MapEntry<PartId, EmailBodyValue> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(PartId(key), EmailBodyValue.fromJson(value));
    } else {
      return MapEntry(PartId(key), value);
    }
  }

  MapEntry<String, dynamic> toJson(PartId partId, EmailBodyValue value) {
    return MapEntry(const PartIdConverter().toJson(partId), value.toJson());
  }
}
