// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSnippet _$SearchSnippetFromJson(Map<String, dynamic> json) =>
    SearchSnippet(
      emailId: Id<Email>.fromJson(json['emailId'] as String),
      subject: json['subject'] as String?,
      preview: json['preview'] as String?,
    );

Map<String, dynamic> _$SearchSnippetToJson(SearchSnippet instance) =>
    <String, dynamic>{
      'emailId': instance.emailId,
      'subject': ?instance.subject,
      'preview': ?instance.preview,
    };
