// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_snippet_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSnippetGetResponse _$SearchSnippetGetResponseFromJson(
  Map<String, dynamic> json,
) => SearchSnippetGetResponse(
  accountId: Id<Account>.fromJson(json['accountId'] as String),
  list: (json['list'] as List<dynamic>?)
      ?.map((e) => SearchSnippet.fromJson(e as Map<String, dynamic>))
      .toList(),
  notFound: (json['notFound'] as List<dynamic>?)
      ?.map((e) => Id<Email>.fromJson(e as String))
      .toList(),
);
