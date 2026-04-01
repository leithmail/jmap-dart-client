import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/method/request/query_method.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/capability/capability_identifier.dart';
import 'package:jmap_dart_client/entities/email/email_filter_condition.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:json_annotation/json_annotation.dart';

class SearchSnippetGetMethod extends GetMethod
    with OptionalFilter, OptionalReferenceEmailIds {
  SearchSnippetGetMethod(super.accountId);

  @override
  MethodName get methodName => MethodName('SearchSnippet/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

  factory SearchSnippetGetMethod.fromJson(Map<String, dynamic> json) {
    return SearchSnippetGetMethod(
        const AccountIdConverter().fromJson(json['accountId']),
      )
      ..filter = json['filter'] == null
          ? null
          : EmailFilterCondition.fromJson(
              json['filter'] as Map<String, dynamic>,
            )
      ..referenceEmailIds = json['#emailIds'] == null
          ? null
          : ResultReference.fromJson(json['#emailIds'] as Map<String, dynamic>);
  }

  @override
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(accountId),
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('filter', filter?.toJson());
    writeNotNull('#emailIds', referenceEmailIds?.toJson());

    return val;
  }
}

mixin OptionalReferenceEmailIds {
  @JsonKey(name: '#emailIds', includeIfNull: false)
  ResultReference? referenceEmailIds;

  void addReferenceEmailIds(RequestInvocation invocation, ReferencePath path) {
    referenceEmailIds = invocation.createResultReference(path);
  }
}
