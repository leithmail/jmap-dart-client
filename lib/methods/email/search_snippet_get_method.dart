import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/method/request/query_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/email/search_snippet_get_response.dart';

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
  SearchSnippetGetResponse responseFromJson(Map<String, dynamic> json) {
    return SearchSnippetGetResponse.fromJson(json);
  }
}

mixin OptionalReferenceEmailIds<
  R extends MethodResponse,
  F extends ResultReference
>
    on Method<R, F> {
  final referenceEmailIds = ArgumentSlot<ResultReference?>(
    'emailIds',
    (v) => v,
  );

  @override
  get slots => [...super.slots, referenceEmailIds];
}
