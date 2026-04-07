// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
  (json['methodResponses'] as List<dynamic>)
      .map((e) => const ResponseInvocationConverter().fromJson(e as List))
      .toList(),
  const StateConverter().fromJson(json['sessionState'] as String),
);
