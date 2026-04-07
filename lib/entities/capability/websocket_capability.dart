import 'package:jmap_dart_client/entities/core/capability_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'websocket_capability.g.dart';

@JsonSerializable(createToJson: false)
class WebSocketCapability extends CapabilityProperties {
  final bool? supportsPush;
  final Uri? url;

  WebSocketCapability({this.supportsPush, this.url});

  factory WebSocketCapability.fromJson(Map<String, dynamic> json) =>
      _$WebSocketCapabilityFromJson(json);

  @override
  List<Object?> get props => [supportsPush, url];
}
