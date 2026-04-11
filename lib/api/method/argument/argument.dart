import 'package:jmap_dart_client/api/request/result_reference.dart';

sealed class Argument<T> {
  const Argument();
}

/// A literal argument value set via [ArgumentSlot.set].
final class ValArgument<T> extends Argument<T> {
  final T value;
  const ValArgument(this.value);
}

/// A result reference set via [ArgumentSlot.ref], pointing to a value
/// in a previous method call's response (RFC 8620 §3.7).
final class RefArgument<T> extends Argument<T> {
  final ResultReference ref;
  const RefArgument(this.ref);
}

/// A typed, named slot for a single JMAP method argument.
///
/// Each argument on a JMAP method is represented as an [ArgumentSlot].
/// A slot knows its JSON key name and how to serialize its value, and can
/// hold either a literal value or a result reference.
///
/// Slots are declared as fields on a [Method] subclass and collected in
/// the [Method.slots] getter so that [Method.toJson] can serialize them
/// automatically.
///
/// Example — declaring slots on a method:
/// ```dart
/// class GetEmailMethod extends GetMethod<GetEmailResponse, GetEmailResultReferenceTree> {
///   final properties = ArgumentSlot<Set<String>>('properties', (v) => v.toList());
///   final collapseThreads = ArgumentSlot<bool>('collapseThreads', (v) => v);
///
///   @override
///   List<ArgumentSlot<dynamic>> get slots => [
///     ...super.slots,
///     properties,
///     collapseThreads,
///   ];
/// }
/// ```
///
/// Example — setting a literal value:
/// ```dart
/// method.properties.set({'id', 'subject', 'from'});
/// ```
///
/// Example — setting a result reference from a previous invocation:
/// ```dart
/// method.ids.ref(queryInvocation.resultReferenceTree.ids);
/// ```
///
/// Unset optional slots are omitted from the serialized request, which is
/// the correct JMAP behaviour for arguments with default values (RFC 8620 §3.5).
class ArgumentSlot<T> {
  final String _key;
  final Object? Function(T) _toJson;
  Argument<T>? _argument;

  /// Creates a slot for JMAP method argument with the given
  /// JSON [key] and [toJson] serializer.
  ///
  /// [toJson] converts the Dart value to a JSON-compatible type. For
  /// primitives, use the identity function `(v) => v`. For custom types,
  /// call `.toJson()`. If [toJson] returns `null`, the slot is omitted
  /// from the serialized output of [Method.toJson].
  ///
  /// Example:
  /// ```dart
  /// // primitive
  /// final limit = ArgumentSlot<int>('limit', (v) => v);
  ///
  /// // custom type
  /// final filter = ArgumentSlot<EmailFilter>('filter', (v) => v.toJson());
  ///
  /// // collection of custom types
  /// final from = ArgumentSlot<List<EmailAddress>>(
  ///   'from',
  ///   (v) => v.map((a) => a.toJson()).toList(),
  /// );
  /// ```
  ArgumentSlot(String key, Object? Function(T) toJson)
    : _key = key,
      _toJson = toJson;

  /// Sets a literal value for this argument.
  void set(T value) => _argument = ValArgument(value);

  /// Sets this argument as a reference to a value in a previous method
  /// call's response, obtained via [Method.resultReference].
  /// Serializes as a `#`-prefixed key per RFC 8620 §3.7.
  void ref(ResultReference ref) => _argument = RefArgument(ref);

  /// Serializes this slot to a [MapEntry] for inclusion in [Method.toJson],
  /// or `null` if the slot has not been set.
  ///
  /// Returns a `#`-prefixed key when the slot holds a [RefArgument].
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
