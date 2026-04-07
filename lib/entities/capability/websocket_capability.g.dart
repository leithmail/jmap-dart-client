// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSocketCapability _$WebSocketCapabilityFromJson(Map<String, dynamic> json) =>
    WebSocketCapability(
      supportsPush: json['supportsPush'] as bool?,
      url: json['url'] == null ? null : Uri.parse(json['url'] as String),
    );
