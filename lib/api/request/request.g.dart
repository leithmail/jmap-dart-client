// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
  const CapabilityIdentifierSetConverter().fromJson(
    json['using'] as List<String>,
  ),
  (json['methodCalls'] as List<dynamic>)
      .map((e) => const RequestInvocationConverter().fromJson(e as List))
      .toList(),
);

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
  'using': const CapabilityIdentifierSetConverter().toJson(instance.using),
  'methodCalls': instance.methodCalls
      .map(const RequestInvocationConverter().toJson)
      .toList(),
};
