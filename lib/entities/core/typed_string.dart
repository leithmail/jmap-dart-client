import 'package:meta/meta.dart';

@immutable
abstract class TypedString {
  final String _value;
  TypedString(String value) : _value = value;

  String get value => _value;
  String toJson() => _value;

  String toString() => _value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypedString &&
          runtimeType == other.runtimeType &&
          _value == other._value;

  @override
  int get hashCode => _value.hashCode ^ runtimeType.hashCode;
}
