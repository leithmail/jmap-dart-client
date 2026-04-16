import 'package:jmap_dart_client/entities/core/typed_string.dart';
import 'package:json_serializable_lints_annotation/json_serializable_lints_annotation.dart';

@RequireFromJson()
class Id<T> extends TypedString {
  Id(String value) : super(value);

  factory Id.fromJson(String json) => Id(json);
}

@RequireFromJson()
class CreationId<T> extends TypedString {
  CreationId(String value) : super(value);

  Id<T> toId() => Id<T>('#${value}');
  Id<S> toIdOf<S>() => Id<S>('#$value');

  factory CreationId.fromJson(String json) => CreationId(json);
}

@RequireFromJson()
class BlobId extends TypedString {
  BlobId(String value) : super(value);

  factory BlobId.fromJson(String json) => BlobId(json);
}
