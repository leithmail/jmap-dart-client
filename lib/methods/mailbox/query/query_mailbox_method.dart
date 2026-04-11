import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/query_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/mailbox/query/query_mailbox_response.dart';
import 'package:jmap_dart_client/src/converters/unsigned_int_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

class QueryMailboxMethod extends QueryMethod<QueryMailboxResponse>
    with FilterAsTree, SortAsTree {
  QueryMailboxMethod(AccountId accountId) : super(accountId);

  @override
  MethodName methodName() => MethodName('Mailbox/query');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

  @override
  Map<String, dynamic> toJson() {
    final val = super.toJson();

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('sortAsTree', sortAsTree);
    writeNotNull('filterAsTree', filterAsTree);
    writeNotNull('filter', filter?.toJson());
    writeNotNull('limit', const UnsignedIntNullableConverter().toJson(limit));
    return val;
  }

  @override
  QueryMailboxResponse responseFromJson(Map<String, dynamic> json) {
    return QueryMailboxResponse.fromJson(json);
  }
}

mixin FilterAsTree {
  @JsonKey(includeIfNull: false)
  bool? filterAsTree;

  void addFilterAsTree(bool value) {
    filterAsTree = value;
  }
}

mixin SortAsTree {
  @JsonKey(includeIfNull: false)
  bool? sortAsTree;

  void addSortAsTree(bool value) {
    sortAsTree = value;
  }
}
