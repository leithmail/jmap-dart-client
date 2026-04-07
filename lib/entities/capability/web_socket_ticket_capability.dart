import 'package:jmap_dart_client/entities/core/capability_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'web_socket_ticket_capability.g.dart';

@JsonSerializable(createToJson: false)
class WebSocketTicketCapability extends CapabilityProperties {
  final Uri? generationEndpoint;
  final Uri? revocationEndpoint;

  WebSocketTicketCapability({
    required this.generationEndpoint,
    required this.revocationEndpoint,
  });

  factory WebSocketTicketCapability.fromJson(Map<String, dynamic> json) =>
      _$WebSocketTicketCapabilityFromJson(json);

  @override
  List<Object?> get props => [generationEndpoint, revocationEndpoint];
}
