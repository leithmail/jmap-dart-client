// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) =>
    Address(json['email'] as String, parameters: json['parameters']);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'email': instance.email,
  'parameters': ?instance.parameters,
};
