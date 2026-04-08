import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/email/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'envelope.g.dart';

@JsonSerializable()
class Envelope with EquatableMixin {
  final Address mailFrom;
  final Set<Address> rcptTo;

  Envelope(this.mailFrom, this.rcptTo);

  factory Envelope.fromJson(Map<String, dynamic> json) =>
      _$EnvelopeFromJson(json);

  Map<String, dynamic> toJson() => _$EnvelopeToJson(this);

  @override
  List<Object?> get props => [mailFrom, rcptTo];
}
