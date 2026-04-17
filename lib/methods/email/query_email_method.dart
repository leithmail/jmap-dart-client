import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/query_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/methods/email/argument/email_comparator.dart';
import 'package:jmap_dart_client/methods/email/argument/email_filter.dart';
import 'package:jmap_dart_client/methods/email/query_email_response.dart';

class QueryEmailMethod
    extends
        QueryMethod<
          Email,
          QueryEmailResponse,
          ResultReference,
          EmailFilter,
          EmailComparator
        >
    with EmptyResultReferences {
  final collapseThreads = PrimitiveSlot<bool>('collapseThreads');

  QueryEmailMethod({required super.accountId});

  @override
  get slots => [...super.slots, collapseThreads];

  @override
  MethodName get methodName => MethodName('Email/query');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapMail,
  ];

  @override
  QueryEmailResponse responseFromJson(Map<String, dynamic> json) {
    return QueryEmailResponse.fromJson(json);
  }
}
