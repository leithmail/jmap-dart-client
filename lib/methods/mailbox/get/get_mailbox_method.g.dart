// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_mailbox_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GetMailboxMethodToJson(GetMailboxMethod instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'ids': ?instance.ids?.map(const IdConverter().toJson).toList(),
      '#ids': ?instance.referenceIds,
      'properties': ?const PropertiesConverter().toJson(instance.properties),
      '#properties': ?instance.referenceProperties,
    };
