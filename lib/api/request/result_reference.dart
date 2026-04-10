import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/src/converters/method_call_id_converter.dart';
import 'package:jmap_dart_client/src/converters/method_name_converter.dart';
import 'package:meta/meta.dart';

/// A JMAP result reference to data produced by an earlier method call.
///
/// Result references are used in later invocations in the same request to
/// refer to values returned by previous method calls. The serialized form is
/// the standard JMAP object:
///
/// ```json
/// {
///   "resultOf": "c0",
///   "name": "Email/get",
///   "path": "/list/*/id"
/// }
/// ```
///
/// In most cases, you do not construct this class directly. Instead, obtain
/// typed references from [RequestInvocation.resultReference] and use the
/// generated [ResultReferenceMap] / [ResultReferenceArray] structure to
/// navigate to the value you want to reference.
class ResultReference {
  @nonVirtual
  final MethodCallId _resultOf;

  @nonVirtual
  final MethodName _name;

  @nonVirtual
  final ReferencePath _path;

  /// Creates a reference to [path] in the result of the method call
  /// identified by [resultOf] and [name].
  ResultReference({
    required MethodCallId resultOf,
    required MethodName name,
    required ReferencePath path,
  }) : _resultOf = resultOf,
       _name = name,
       _path = path;

  /// Serializes this reference into the JMAP JSON shape expected for
  /// `#resultReference` arguments.
  Map<String, dynamic> toJson() => <String, dynamic>{
    'resultOf': const MethodCallIdConverter().toJson(_resultOf),
    'name': const MethodNameConverter().toJson(_name),
    'path': _path.toPointer(),
  };
}

/// Base class for typed navigation over a JMAP method result.
///
/// Extend this class to describe the shape of a response returned by
/// [RequestInvocation.resultReference]. A subclass typically exposes
/// three kinds of fields:
///
/// - **Scalar leaf** — a [ResultReference] for a primitive value:
///   ```dart
///   late final ResultReference id;
///   id = $('id');
///   ```
///
/// - **Nested object** — a sub-[ResultReferenceMap] for an object field:
///   ```dart
///   late final AddressResultReferenceMap from;
///   from = AddressResultReferenceMap($('from'));
///   ```
///
/// - **Array** — a [ResultReferenceArray] for an array field:
///   ```dart
///   late final ResultReferenceArray<ResultReference> tags;
///   tags = ResultReferenceArray($('tags'), (ref) => ref);
///   ```
///
/// Since [ResultReferenceMap] extends [ResultReference], each node is already
/// a usable JMAP result reference for its current path. Use [$] in subclass
/// constructors to build child paths.
///
/// Full example:
/// ```dart
/// class AddressResultReferenceMap extends ResultReferenceMap {
///   late final ResultReference email;
///   late final ResultReference name;
///
///   AddressResultReferenceMap(super.resultReference) {
///     email = $('email');
///     name  = $('name');
///   }
/// }
///
/// class EmailResultReferenceMap extends ResultReferenceMap {
///   late final ResultReference id;
///   late final ResultReference subject;
///   late final AddressResultReferenceMap from;
///   late final ResultReferenceArray<ResultReference> tags;
///
///   EmailResultReferenceMap(super.resultReference) {
///     id      = $('id');
///     subject = $('subject');
///     from    = AddressResultReferenceMap($('from'));
///     tags    = ResultReferenceArray($('tags'), (ref) => ref);
///   }
/// }
///
/// class GetEmailResultReferenceMap extends ResultReferenceMap {
///   late final ResultReferenceArray<EmailResultReferenceMap> list;
///   late final ResultReferenceArray<ResultReference> notFound;
///
///   GetEmailResultReferenceMap(super.resultReference) {
///     list     = ResultReferenceArray($('list'), EmailResultReferenceMap.new);
///     notFound = ResultReferenceArray($('notFound'), (ref) => ref);
///   }
/// }
///
/// // Usage:
/// final refs = invocation.resultReference();
///
/// refs.list                      // /list
/// refs.list.$each.id             // /list/*/id
/// refs.list.$each.from.email     // /list/*/from/email
/// refs.list.$each.tags           // /list/*/tags
/// refs.list.$each.tags.$each     // /list/*/tags/*
/// refs.notFound                  // /notFound
/// ```
class ResultReferenceMap extends ResultReference {
  ResultReferenceMap(ResultReference resultReference)
    : super(
        resultOf: resultReference._resultOf,
        name: resultReference._name,
        path: resultReference._path,
      );

  /// Appends [segment] to the current path, returning a [ResultReference]
  /// for use as a scalar leaf or as input to a sub-tree constructor.
  /// For use by subclasses only.
  @protected
  @nonVirtual
  ResultReference $(String segment) {
    return ResultReference(
      resultOf: _resultOf,
      name: _name,
      path: _path.append(segment),
    );
  }
}

/// A [ResultReferenceMap] node representing an array field.
///
/// [T] is the element type after traversal via [$each]:
/// - [ResultReference] for scalar arrays (`String[]`, `Id[]`, etc.)
/// - A sub-[ResultReferenceMap] for arrays of objects
///
/// ```dart
/// // Scalar array:
/// ResultReferenceArray<ResultReference>($('ids'), (ref) => ref)
///
/// // Array of objects:
/// ResultReferenceArray<EmailResultReferenceMap>($('list'), EmailResultReferenceMap.new)
/// ```
class ResultReferenceArray<T> extends ResultReferenceMap {
  /// Traverses into each element by appending `*` to the current path.
  @nonVirtual
  late final T $each;

  ResultReferenceArray(
    super.resultReference,
    T Function(ResultReference) eachFactory,
  ) {
    $each = eachFactory($('*'));
  }
}
