import 'package:jmap_dart_client/entities/core/typed_string.dart';
import 'package:json_serializable_lints_annotation/json_serializable_lints_annotation.dart';
import 'package:meta/meta.dart';

@immutable
@RequireFromJson()
class State<T> extends TypedString {
  State(String value) : super(value);

  factory State.fromJson(String json) => State(json);
}
