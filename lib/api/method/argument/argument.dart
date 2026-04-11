import 'package:jmap_dart_client/api/request/result_reference.dart';

sealed class Argument<T> {
  const Argument();

  Map<String, dynamic> toEntry(String key) => switch (this) {
    ValArgument<T> a => {key: a.value},
    RefArgument<T> a => {'#$key': a.ref.toJson()},
  };
}

final class ValArgument<T> extends Argument<T> {
  final T value;
  const ValArgument(this.value);
}

final class RefArgument<T> extends Argument<T> {
  final ResultReference ref;
  const RefArgument(this.ref);
}

class ArgumentSlot<T> {
  final String _key;
  final Object? Function(T) _toJson;
  Argument<T>? _argument;

  ArgumentSlot(this._key, this._toJson);

  void set(T value) => _argument = ValArgument(value);
  void ref(ResultReference ref) => _argument = RefArgument(ref);

  MapEntry<String, dynamic>? toEntry() => switch (_argument) {
    null => null,
    ValArgument<T> a => _valueEntry(a.value),
    RefArgument<T> a => MapEntry('#$_key', a.ref.toJson()),
  };

  MapEntry<String, dynamic>? _valueEntry(T value) {
    final v = _toJson(value);
    return v == null ? null : MapEntry(_key, v);
  }
}
