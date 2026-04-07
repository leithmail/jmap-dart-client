// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
  'using': const CapabilityIdentifierSetConverter().toJson(instance.using),
  'methodCalls': instance.methodCalls
      .map(const RequestInvocationConverter().toJson)
      .toList(),
};
