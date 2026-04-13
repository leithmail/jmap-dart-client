import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/argument/filter.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/methods/email/argument/email_filter.dart';
import 'package:jmap_dart_client/methods/email/search_snippet_get_response.dart';

class SearchSnippetGetMethod
    extends MethodWithAccountId<SearchSnippetGetResponse, ResultReference>
    with EmptyResultReferences {
  final filter = FilterSlot<EmailFilter>('filter');
  final emailIds = ListArgumentSlot<EmailId>('emailIds', (v) => v.id.value);

  SearchSnippetGetMethod({required super.accountId});

  @override
  MethodName get methodName => MethodName('SearchSnippet/get');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapMail,
  ];

  @override
  SearchSnippetGetResponse responseFromJson(Map<String, dynamic> json) {
    return SearchSnippetGetResponse.fromJson(json);
  }

  @override
  get slots => [...super.slots, filter, emailIds];
}
