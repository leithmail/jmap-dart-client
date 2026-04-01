// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestObject _$RequestObjectFromJson(Map<String, dynamic> json) =>
    RequestObject(
      const CapabilityIdentifierSetConverter().fromJson(
        json['using'] as List<String>,
      ),
      (json['methodCalls'] as List<dynamic>)
          .map((e) => const RequestInvocationConverter().fromJson(e as List))
          .toList(),
    );

Map<String, dynamic> _$RequestObjectToJson(RequestObject instance) =>
    <String, dynamic>{
      'using': const CapabilityIdentifierSetConverter().toJson(instance.using),
      'methodCalls': instance.methodCalls
          .map(const RequestInvocationConverter().toJson)
          .toList(),
    };
