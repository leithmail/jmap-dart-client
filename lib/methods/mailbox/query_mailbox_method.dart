import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/query_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/mailbox/mailbox.dart';
import 'package:jmap_dart_client/methods/mailbox/argument/mailbox_comparator.dart';
import 'package:jmap_dart_client/methods/mailbox/argument/mailbox_filter.dart';
import 'package:jmap_dart_client/methods/mailbox/query_mailbox_response.dart';

class QueryMailboxMethod
    extends
        QueryMethod<
          Mailbox,
          QueryMailboxResponse,
          ResultReference,
          MailboxFilter,
          MailboxComparator
        >
    with EmptyResultReferences {
  final filterAsTree = PrimitiveSlot<bool>('filterAsTree');
  final sortAsTree = PrimitiveSlot<bool>('sortAsTree');

  QueryMailboxMethod({required super.accountId});

  @override
  MethodName get methodName => MethodName('Mailbox/query');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapMail,
  ];

  @override
  QueryMailboxResponse responseFromJson(Map<String, dynamic> json) {
    return QueryMailboxResponse.fromJson(json);
  }
}
