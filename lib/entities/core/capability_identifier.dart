import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class CapabilityIdentifier with EquatableMixin {
  static final jmapCore = CapabilityIdentifier(
    Uri.parse('urn:ietf:params:jmap:core'),
  );
  static final jmapMail = CapabilityIdentifier(
    Uri.parse('urn:ietf:params:jmap:mail'),
  );
  static final jmapSubmission = CapabilityIdentifier(
    Uri.parse('urn:ietf:params:jmap:submission'),
  );
  static final jmapVacationResponse = CapabilityIdentifier(
    Uri.parse('urn:ietf:params:jmap:vacationresponse'),
  );
  static final jmapWebSocket = CapabilityIdentifier(
    Uri.parse('urn:ietf:params:jmap:websocket'),
  );
  static final jmapMdn = CapabilityIdentifier(
    Uri.parse('urn:ietf:params:jmap:mdn'),
  );
  static final jmapQuota = CapabilityIdentifier(
    Uri.parse('urn:ietf:params:jmap:quota'),
  );

  final Uri value;

  CapabilityIdentifier(this.value);

  String toJson() => value.toString();

  @override
  List<Object> get props => [value];
}
