import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/method/request/query_method.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/email/search_snippet_get_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:json_annotation/json_annotation.dart';

class SearchSnippetGetMethod extends GetMethod<SearchSnippetGetResponse>
    with OptionalFilter, OptionalReferenceEmailIds {
  SearchSnippetGetMethod(super.accountId);

  @override
  MethodName methodName() => MethodName('SearchSnippet/get');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

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

  @override
  SearchSnippetGetResponse responseFromJson(Map<String, dynamic> json) {
    return SearchSnippetGetResponse.fromJson(json);
  }
}

mixin OptionalReferenceEmailIds {
  @JsonKey(name: '#emailIds', includeIfNull: false)
  ResultReference? referenceEmailIds;

  void addReferenceEmailIds(RequestInvocation invocation, ReferencePath path) {
    referenceEmailIds = invocation.createResultReference(path);
  }
}
