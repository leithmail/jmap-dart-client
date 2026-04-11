import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/method/request/query_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/email/query_email_response.dart';

class QueryEmailMethod extends QueryMethod<QueryEmailResponse>
    with OptionalCollapseThreads {
  QueryEmailMethod(AccountId accountId) : super(accountId);

  @override
  MethodName methodName() => MethodName('Email/query');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

  @override
  QueryEmailResponse responseFromJson(Map<String, dynamic> json) {
    return QueryEmailResponse.fromJson(json);
  }
}

mixin OptionalCollapseThreads<
  R extends MethodResponse,
  F extends ResultReference
>
    on Method<R, F> {
  final collapseThreads = ArgumentSlot<bool?>('collapseThreads', (v) => v);

  @override
  get slots => [...super.slots, collapseThreads];
}
