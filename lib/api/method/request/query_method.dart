import 'package:jmap_dart_client/api/method/argument/filter/filter.dart';
import 'package:jmap_dart_client/api/method/argument/sort/comparator.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:json_annotation/json_annotation.dart';

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

mixin OptionalPosition {
  @JsonKey(includeIfNull: false)
  int? position;

  void addPosition(int value) {
    position = value;
  }
}

mixin OptionalAnchorOffset {
  @JsonKey(includeIfNull: false)
  int? anchorOffset;

  void addAnchorOffset(int value) {
    anchorOffset = value;
  }
}

mixin OptionalCalculateTotal {
  @JsonKey(includeIfNull: false)
  bool? calculateTotal;

  void addCalculateTotal(bool value) {
    calculateTotal = value;
  }
}

mixin OptionalFilter {
  @JsonKey(includeIfNull: false)
  Filter? filter;

  void addFilters(Filter value) {
    filter = value;
  }
}

mixin OptionalSort {
  @JsonKey(includeIfNull: false)
  List<Comparator>? sort;

  void addSorts(List<Comparator> value) {
    sort ??= <Comparator>[];
    sort?.addAll(value);
  }
}

mixin OptionalAnchor {
  @JsonKey(includeIfNull: false)
  Id? anchor;

  void addAnchor(Id value) {
    anchor = value;
  }
}

mixin OptionalLimit {
  @JsonKey(includeIfNull: false)
  UnsignedInt? limit;

  void addLimit(int value) {
    limit = UnsignedInt(value);
  }
}
