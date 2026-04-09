// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_email_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GetEmailMethodToJson(GetEmailMethod instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'ids': ?instance.ids?.map(const IdConverter().toJson).toList(),
      '#ids': ?instance.referenceIds,
      'bodyProperties': ?instance.bodyProperties,
      'properties': ?const PropertiesConverter().toJson(instance.properties),
      'fetchTextBodyValues': ?instance.fetchTextBodyValues,
      '#properties': ?instance.referenceProperties,
      'fetchHTMLBodyValues': ?instance.fetchHTMLBodyValues,
      'fetchAllBodyValues': ?instance.fetchAllBodyValues,
      'maxBodyValueBytes': ?const UnsignedIntNullableConverter().toJson(
        instance.maxBodyValueBytes,
      ),
    };
