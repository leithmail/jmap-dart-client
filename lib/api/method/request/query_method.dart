import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/argument/comparator.dart';
import 'package:jmap_dart_client/api/method/argument/filter.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/id.dart';

abstract class QueryMethod<
  R extends MethodResponse,
  Q extends ResultReference,
  F extends Filter,
  S extends Comparator
>
    extends MethodWithAccountId<R, Q> {
  QueryMethod({required super.accountId});

  final position = PrimitiveArgumentSlot<int>('position');
  final limit = PrimitiveArgumentSlot<int>('limit');
  final anchor = ArgumentSlot<Id>('anchor', (v) => v.value);
  final anchorOffset = PrimitiveArgumentSlot<int>('anchorOffset');
  final calculateTotal = PrimitiveArgumentSlot<bool>('calculateTotal');
  final filter = FilterSlot<F>('filter');
  final sort = SortSlot<Comparator>('sort');

  @override
  get slots => [
    ...super.slots,
    position,
    limit,
    anchor,
    anchorOffset,
    calculateTotal,
    filter,
    sort,
  ];
}
