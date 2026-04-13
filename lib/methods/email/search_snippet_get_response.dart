import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/email/search_snippet.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_snippet_get_response.g.dart';

@IdConverter()
@JsonSerializable(createToJson: false)
class SearchSnippetGetResponse extends ResponseRequiringAccountId {
  SearchSnippetGetResponse(super.accountId, this.list, this.notFound);

  final List<SearchSnippet>? list;
  final List<Id>? notFound;

  factory SearchSnippetGetResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchSnippetGetResponseFromJson(json);
}
