import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/argument/filter/filter.dart';
import 'package:jmap_dart_client/api/method/argument/sort/comparator.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';

abstract class QueryMethod<R extends MethodResponse>
    extends MethodRequiringAccountId<R>
    with
        OptionalPosition,
        OptionalAnchorOffset,
        OptionalCalculateTotal,
        OptionalFilter,
        OptionalSort,
        OptionalAnchor,
        OptionalLimit {
  QueryMethod(AccountId accountId) : super(accountId);
}

mixin OptionalPosition<R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  final position = ArgumentSlot<int>('position', (v) => v);

  void addPosition(int value) {
    position.set(value);
  }

  @override
  get slots => [...super.slots, position];
}

mixin OptionalAnchorOffset<R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  final anchorOffset = ArgumentSlot<int>('anchorOffset', (v) => v);

  void addAnchorOffset(int value) {
    anchorOffset.set(value);
  }

  @override
  get slots => [...super.slots, anchorOffset];
}

mixin OptionalCalculateTotal<
  R extends MethodResponse,
  F extends ResultReference
>
    on Method<R, F> {
  final calculateTotal = ArgumentSlot<bool>('calculateTotal', (v) => v);

  void addCalculateTotal(bool value) {
    calculateTotal.set(value);
  }

  @override
  get slots => [...super.slots, calculateTotal];
}

mixin OptionalFilter<R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  final filter = ArgumentSlot<Filter>('filter', (v) => v.toJson());

  void addFilters(Filter value) {
    filter.set(value);
  }

  @override
  get slots => [...super.slots, filter];
}

mixin OptionalSort<R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  final sort = ArgumentSlot<List<Comparator>>(
    'sort',
    (v) => v.map((e) => e.toJson()).toList(),
  );

  void addSorts(List<Comparator> value) {
    sort.set(value);
  }

  @override
  get slots => [...super.slots, sort];
}

mixin OptionalAnchor<R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  final anchor = ArgumentSlot<Id>('anchor', (v) => v.value);

  void addAnchor(Id value) {
    anchor.set(value);
  }

  @override
  get slots => [...super.slots, anchor];
}

mixin OptionalLimit<R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  final limit = ArgumentSlot<UnsignedInt>('limit', (v) => v.value);

  void addLimit(int value) {
    limit.set(UnsignedInt(value));
  }

  @override
  get slots => [...super.slots, limit];
}
