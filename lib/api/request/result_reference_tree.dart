import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:meta/meta.dart';

/// Base class for typed navigation trees over a JMAP method response.
///
/// Extend this class to describe the shape of a response, with three kinds
/// of fields:
///
/// - **Scalar leaf** — a [ResultReference] for a primitive value:
///   ```dart
///   late final ResultReference id;
///   id = $('id');
///   ```
///
/// - **Nested object** — a sub-[ResultReferenceTree] for an object field:
///   ```dart
///   late final AddressResultReferenceTree from;
///   from = AddressResultReferenceTree($('from'));
///   ```
///
/// - **Array** — a [ResultReferenceArray] for an array field:
///   ```dart
///   late final ResultReferenceArray<ResultReference> tags;
///   tags = ResultReferenceArray($('tags'), (ref) => ref);
///   ```
///
/// Use [$ref] to obtain the [ResultReference] for this node's path as-is,
/// and [$] to build child paths in subclass constructors.
///
/// Full example:
/// ```dart
/// class AddressResultReferenceTree extends ResultReferenceTree {
///   late final ResultReference email;
///   late final ResultReference name;
///
///   AddressResultReferenceTree(super.resultReference) {
///     email = $('email');
///     name  = $('name');
///   }
/// }
///
/// class EmailResultReferenceTree extends ResultReferenceTree {
///   late final ResultReference id;
///   late final ResultReference subject;
///   late final AddressResultReferenceTree from;
///   late final ResultReferenceArray<ResultReference> tags;
///
///   EmailResultReferenceTree(super.resultReference) {
///     id      = $('id');
///     subject = $('subject');
///     from    = AddressResultReferenceTree($('from'));
///     tags    = ResultReferenceArray($('tags'), (ref) => ref);
///   }
/// }
///
/// class GetEmailResultReferenceTree extends ResultReferenceTree {
///   late final ResultReferenceArray<EmailResultReferenceTree> list;
///   late final ResultReferenceArray<ResultReference> notFound;
///
///   GetEmailResultReferenceTree(super.resultReference) {
///     list     = ResultReferenceArray($('list'), EmailResultReferenceTree.new);
///     notFound = ResultReferenceArray($('notFound'), (ref) => ref);
///   }
/// }
///
/// // Usage:
/// tree.list.$ref                 // /list
/// tree.list.$each.id             // /list/*/id
/// tree.list.$each.from.email     // /list/*/from/email
/// tree.list.$each.tags.$ref      // /list/*/tags
/// tree.list.$each.tags.$each     // /list/*/tags/*
/// tree.notFound.$ref             // /notFound
/// ```
class ResultReferenceTree {
  final ResultReference _resultReference;

  ResultReferenceTree(ResultReference resultReference)
    : _resultReference = resultReference;

  /// Appends [segment] to the current path, returning a [ResultReference]
  /// for use as a scalar leaf or as input to a sub-tree constructor.
  /// For use by subclasses only.
  @protected
  @nonVirtual
  ResultReference $(String segment) {
    return ResultReference(
      resultOf: _resultReference.resultOf,
      name: _resultReference.name,
      path: _resultReference.path.append(segment),
    );
  }

  /// The [ResultReference] for this node's path as-is.
  @nonVirtual
  ResultReference get $ref => _resultReference;
}

/// A [ResultReferenceTree] node representing an array field.
///
/// [T] is the element type after traversal via [$each]:
/// - [ResultReference] for scalar arrays (`String[]`, `Id[]`, etc.)
/// - A sub-[ResultReferenceTree] for arrays of objects
///
/// ```dart
/// // Scalar array:
/// ResultReferenceArray<ResultReference>($('ids'), (ref) => ref)
///
/// // Array of objects:
/// ResultReferenceArray<EmailResultReferenceTree>($('list'), EmailResultReferenceTree.new)
/// ```
class ResultReferenceArray<T> extends ResultReferenceTree {
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
