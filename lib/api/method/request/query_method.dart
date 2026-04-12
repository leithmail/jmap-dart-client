import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/argument/comparator.dart';
import 'package:jmap_dart_client/api/method/argument/filter.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';

abstract class QueryMethod<
  R extends MethodResponse,
  F extends Filter,
  S extends Comparator
>
    extends MethodRequiringAccountId<R>
    with
        OptionalPosition,
        OptionalAnchorOffset,
        OptionalCalculateTotal,
        OptionalFilter<R, ResultReference, F>,
        OptionalSort<R, ResultReference, S>,
        OptionalAnchor,
        OptionalLimit {
  QueryMethod(AccountId accountId) : super(accountId);
}

mixin OptionalPosition<R extends MethodResponse, Q extends ResultReference>
    on Method<R, Q> {
  final position = ArgumentSlot<int>('position', (v) => v);

  @override
  get slots => [...super.slots, position];
}

mixin OptionalAnchorOffset<R extends MethodResponse, Q extends ResultReference>
    on Method<R, Q> {
  final anchorOffset = ArgumentSlot<int>('anchorOffset', (v) => v);

  @override
  get slots => [...super.slots, anchorOffset];
}

mixin OptionalCalculateTotal<
  R extends MethodResponse,
  Q extends ResultReference
>
    on Method<R, Q> {
  final calculateTotal = ArgumentSlot<bool>('calculateTotal', (v) => v);

  @override
  get slots => [...super.slots, calculateTotal];
}

mixin OptionalFilter<
  R extends MethodResponse,
  Q extends ResultReference,
  F extends Filter
>
    on Method<R, Q> {
  final filter = FilterSlot<F>('filter');

  @override
  get slots => [...super.slots, filter];
}

mixin OptionalSort<
  R extends MethodResponse,
  Q extends ResultReference,
  S extends Comparator
>
    on Method<R, Q> {
  final sort = SortSlot<Comparator>('sort');

  @override
  get slots => [...super.slots, sort];
}

mixin OptionalAnchor<R extends MethodResponse, Q extends ResultReference>
    on Method<R, Q> {
  final anchor = ArgumentSlot<Id>('anchor', (v) => v.value);

  @override
  get slots => [...super.slots, anchor];
}

mixin OptionalLimit<R extends MethodResponse, Q extends ResultReference>
    on Method<R, Q> {
  final limit = ArgumentSlot<UnsignedInt>('limit', (v) => v.value);

  @override
  get slots => [...super.slots, limit];
}
