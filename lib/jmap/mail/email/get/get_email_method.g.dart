// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_email_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEmailMethod _$GetEmailMethodFromJson(Map<String, dynamic> json) =>
    GetEmailMethod(
        const AccountIdConverter().fromJson(json['accountId'] as String),
      )
      ..ids = (json['ids'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toSet()
      ..referenceIds = json['#ids'] == null
          ? null
          : ResultReference.fromJson(json['#ids'] as Map<String, dynamic>)
      ..properties = const PropertiesConverter().fromJson(
        json['properties'] as List<String>?,
      )
      ..referenceProperties = json['#properties'] == null
          ? null
          : ResultReference.fromJson(
              json['#properties'] as Map<String, dynamic>,
            )
      ..bodyProperties = json['bodyProperties'] == null
          ? null
          : EmailBodyProperties.fromJson(
              json['bodyProperties'] as Map<String, dynamic>,
            )
      ..fetchTextBodyValues = json['fetchTextBodyValues'] as bool?
      ..fetchHTMLBodyValues = json['fetchHTMLBodyValues'] as bool?
      ..fetchAllBodyValues = json['fetchAllBodyValues'] as bool?
      ..maxBodyValueBytes = const UnsignedIntNullableConverter().fromJson(
        (json['maxBodyValueBytes'] as num?)?.toInt(),
      );

Map<String, dynamic> _$GetEmailMethodToJson(GetEmailMethod instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'ids': ?instance.ids?.map(const IdConverter().toJson).toList(),
      '#ids': ?instance.referenceIds?.toJson(),
      'properties': ?const PropertiesConverter().toJson(instance.properties),
      '#properties': ?instance.referenceProperties?.toJson(),
      'bodyProperties': ?instance.bodyProperties?.toJson(),
      'fetchTextBodyValues': ?instance.fetchTextBodyValues,
      'fetchHTMLBodyValues': ?instance.fetchHTMLBodyValues,
      'fetchAllBodyValues': ?instance.fetchAllBodyValues,
      'maxBodyValueBytes': ?const UnsignedIntNullableConverter().toJson(
        instance.maxBodyValueBytes,
      ),
    };
