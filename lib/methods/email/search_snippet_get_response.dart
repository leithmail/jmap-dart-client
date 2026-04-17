import 'package:jmap_dart_client/jmap_dart_client.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_snippet_get_response.g.dart';

@JsonSerializable(createToJson: false)
class SearchSnippetGetResponse extends MethodResponse {
  final AccountId accountId;
  final List<SearchSnippet>? list;
  final List<Id<Email>>? notFound;

  factory SearchSnippetGetResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchSnippetGetResponseFromJson(json);

  SearchSnippetGetResponse({required this.accountId, this.list, this.notFound});
}
