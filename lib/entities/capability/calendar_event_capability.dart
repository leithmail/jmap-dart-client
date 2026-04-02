import 'package:jmap_dart_client/entities/core/capability_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event_capability.g.dart';

@JsonSerializable(includeIfNull: false)
class CalendarEventCapability extends CapabilityProperties {
  final List<String>? replySupportedLanguage;
  final bool? supportFreeBusyQuery;
  final bool? counterSupport;

  CalendarEventCapability({
    List<String>? replySupportedLanguage,
    this.supportFreeBusyQuery,
    this.counterSupport,
  }) : replySupportedLanguage = replySupportedLanguage == null
           ? null
           : List.unmodifiable(replySupportedLanguage);

  factory CalendarEventCapability.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventCapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventCapabilityToJson(this);

  @override
  List<Object?> get props => [
    replySupportedLanguage,
    supportFreeBusyQuery,
    counterSupport,
  ];
}
