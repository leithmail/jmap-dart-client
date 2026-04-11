import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/method/request/query_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/mailbox/query/query_mailbox_response.dart';

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
  QueryMailboxResponse responseFromJson(Map<String, dynamic> json) {
    return QueryMailboxResponse.fromJson(json);
  }
}

mixin FilterAsTree<R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  final filterAsTree = ArgumentSlot<bool?>('filterAsTree', (v) => v);

  void addFilterAsTree(bool value) {
    filterAsTree.set(value);
  }

  @override
  get slots => [...super.slots, filterAsTree];
}

mixin SortAsTree<R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  final sortAsTree = ArgumentSlot<bool?>('sortAsTree', (v) => v);

  void addSortAsTree(bool value) {
    sortAsTree.set(value);
  }

  @override
  get slots => [...super.slots, sortAsTree];
}
