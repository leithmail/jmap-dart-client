import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:meta/meta.dart';

/// A typed tree for navigating the response shape of a previous JMAP method
/// call and producing [ResultReference] values for use in subsequent method
/// calls within the same request.
///
/// Subclasses are generated for each [MethodResponse] type and mirror its
/// field structure. Leaf fields are [ResultReference] instances; nested
/// objects are sub-[ResultReferenceTree] instances; arrays are
/// [ResultReferenceArray] instances exposing [ResultReferenceArray.each].
///
/// Example:
/// ```dart
/// // Given a generated tree for Email/query response:
/// class QueryEmailResultReferenceTree extends ResultReferenceTree {
///   late final ResultReference ids;
///
///   QueryEmailResultReferenceTree(super.resultReference) {
///     ids = $('ids');
///   }
/// }
///
/// // Use it to chain Email/query → Email/get in a single request:
/// final queryInvocation = requestBuilder.addInvocation(queryEmailMethod);
///
/// final getEmailMethod = GetEmailMethod()
///   ..accountId.set(accountId)
///   ..ids.ref(queryInvocation.resultReferenceTree.ids);
/// ```
class ResultReferenceTree {
  final ResultReference _resultReference;

  ResultReferenceTree(ResultReference resultReference)
    : _resultReference = resultReference;

  /// Produces a [ResultReference] pointing to [ref] within this node's
  /// path. For use by subclasses only — call this in the constructor to
  /// initialise leaf and sub-tree fields.
  ///
  /// Example:
  /// ```dart
  /// class MyTree extends ResultReferenceTree {
  ///   late final ResultReference id;
  ///   late final MySubTree nested;
  ///
  ///   MyTree(super.resultReference) {
  ///     id     = $('id');
  ///     nested = MySubTree($('nested'));
  ///   }
  /// }
  /// ```
  @protected
  ResultReference $(String ref) {
    return ResultReference(
      resultOf: _resultReference.resultOf,
      name: _resultReference.name,
      path: _resultReference.path.append(ref),
    );
  }
}
