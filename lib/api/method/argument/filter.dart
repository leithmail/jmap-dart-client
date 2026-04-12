import 'package:jmap_dart_client/api/method/argument/argument.dart';

/// JMAP filter types for use with `/query` methods (RFC 8620 §5.5).
///
/// A filter is either a [FilterConditionBase] (a leaf node with
/// method-specific criteria) or a [FilterOperatorBase] (a logical
/// combinator of other filters).
///
/// ## Defining method-specific filters
///
/// For each `/query` method, define three things:
///
/// 1. A private raw condition class annotated with `@JsonSerializable`
/// 2. A public condition class extending [FilterConditionBase]
/// 3. A public operator class extending [FilterOperatorBase]
/// 4. A typedef for convenience
///
/// ```dart
/// typedef MailboxFilter = Filter<_MailboxFilterCondition>;
///
/// class MailboxFilterOperator extends FilterOperatorBase<_MailboxFilterCondition> {
///   MailboxFilterOperator(super.operator, super.conditions);
/// }
///
/// class MailboxFilterCondition extends FilterConditionBase<_MailboxFilterCondition> {
///   MailboxFilterCondition({Role? role, MailboxName? name}) : super(
///     _MailboxFilterCondition(role: role, name: name),
///   );
/// }
///
/// @JsonSerializable(createFactory: false, includeIfNull: false)
/// class _MailboxFilterCondition extends FilterCondition {
///   final Role? role;
///   final MailboxName? name;
///   // ...
///   @override
///   Map<String, dynamic> toJson() => _$MailboxFilterConditionToJson(this);
/// }
/// ```
///
/// ## Building a filter tree
///
/// Simple condition:
/// ```dart
/// method.filter.val(MailboxFilterCondition(role: Role('Spam')));
/// ```
///
/// Compound filter with operator:
/// ```dart
/// method.filter.val(
///   MailboxFilterOperator(Operator.AND, [
///     MailboxFilterCondition(role: Role('Inbox')),
///     MailboxFilterOperator(Operator.OR, [
///       MailboxFilterCondition(isSubscribed: true),
///       MailboxFilterCondition(hasAnyRole: true),
///     ]),
///   ]),
/// );
/// ```

/// Raw filter condition interface. Implement this with `@JsonSerializable`
/// to define the JSON shape of a method-specific filter condition.
/// Not intended to be used directly — wrap with [FilterConditionBase].
abstract class FilterCondition {
  Map<String, dynamic> toJson();
}

/// Base sealed class for all JMAP filters. Parameterized over the
/// method-specific [FilterCondition] type to prevent mixing conditions
/// from different methods in the same filter tree.
sealed class Filter<T extends FilterCondition> {
  Map<String, dynamic> toJson();
}

/// Base class for leaf filter nodes. Wraps a [FilterCondition] and
/// delegates serialization to it. Extend this to define a public
/// filter condition for a specific method.
abstract class FilterConditionBase<T extends FilterCondition>
    extends Filter<T> {
  final T _condition;

  FilterConditionBase(T condition) : _condition = condition;

  @override
  Map<String, dynamic> toJson() => _condition.toJson();
}

/// Base class for logical filter combinators. Extend this to define
/// a public filter operator for a specific method.
abstract class FilterOperatorBase<T extends FilterCondition> extends Filter<T> {
  final Operator operator;
  final List<Filter<T>> conditions;

  FilterOperatorBase(this.operator, this.conditions);

  @override
  Map<String, dynamic> toJson() => {
    'operator': operator.name,
    'conditions': conditions.map((e) => e.toJson()).toList(),
  };
}

/// Logical operator for combining filter conditions (RFC 8620 §5.5).
enum Operator { AND, OR, NOT }

/// Argument slot for the `filter` argument on JMAP `/query` methods.
///
/// Usage:
///
/// ```dart
/// final slot = FilterSlot<MailboxFilter>('filter');
///
/// slot.val(
///   MailboxFilterOperator(Operator.AND, [
///     MailboxFilterCondition(role: Role('Inbox')),
///     MailboxFilterCondition(isSubscribed: true),
///   ]),
/// );
///
/// final entry = slot.toEntry();
/// // Produces: MapEntry('filter', <serialized filter json>)
/// ```
class FilterSlot<T extends Filter> extends ArgumentSlotBase {
  final String _key;
  T? _filter;

  FilterSlot(this._key);

  /// Stores the filter that will be serialized by [toEntry].
  void set(T filter) => _filter = filter;

  /// Returns a map entry with the configured key and serialized filter.
  ///
  /// Returns `null` when no filter was set.
  MapEntry<String, dynamic>? toEntry() {
    if (_filter == null) return null;
    return MapEntry(_key, _filter!.toJson());
  }
}
