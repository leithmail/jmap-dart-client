// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_snippet_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSnippetGetResponse _$SearchSnippetGetResponseFromJson(
  Map<String, dynamic> json,
) => SearchSnippetGetResponse(
  const AccountIdConverter().fromJson(json['accountId'] as String),
  (json['list'] as List<dynamic>?)
      ?.map((e) => SearchSnippet.fromJson(e as Map<String, dynamic>))
      .toList(),
  (json['notFound'] as List<dynamic>?)
      ?.map((e) => const IdConverter().fromJson(e as String))
      .toList(),
);
