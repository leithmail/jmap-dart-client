import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/query_method.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/email/query_email_response.dart';
import 'package:jmap_dart_client/src/converters/id_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/unsigned_int_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

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
  Map<String, dynamic> toJson() {
    final val = super.toJson();

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('position', position);
    writeNotNull('anchorOffset', anchorOffset);
    writeNotNull('calculateTotal', calculateTotal);
    writeNotNull('collapseThreads', collapseThreads);
    writeNotNull('filter', filter?.toJson());
    writeNotNull('sort', sort?.map((e) => e.toJson()).toList());
    writeNotNull('anchor', const IdNullableConverter().toJson(anchor));
    writeNotNull('limit', const UnsignedIntNullableConverter().toJson(limit));
    return val;
  }

  @override
  QueryEmailResponse responseFromJson(Map<String, dynamic> json) {
    return QueryEmailResponse.fromJson(json);
  }
}

mixin OptionalCollapseThreads {
  @JsonKey(includeIfNull: false)
  bool? collapseThreads;

  void addCollapseThreads(bool value) {
    collapseThreads = value;
  }
}
