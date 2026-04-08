// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryEmailResponse _$QueryEmailResponseFromJson(Map<String, dynamic> json) =>
    QueryEmailResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['queryState'] as String),
      json['canCalculateChanges'] as bool,
      const UnsignedIntConverter().fromJson((json['position'] as num).toInt()),
      (json['ids'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toSet(),
      _$JsonConverterFromJson<int, UnsignedInt>(
        json['total'],
        const UnsignedIntConverter().fromJson,
      ),
      _$JsonConverterFromJson<int, UnsignedInt>(
        json['limit'],
        const UnsignedIntConverter().fromJson,
      ),
    );

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);
