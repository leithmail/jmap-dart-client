import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/utc_date.dart';
import 'package:jmap_dart_client/entities/push/encryption_key.dart';
import 'package:jmap_dart_client/src/converters/utc_date_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'push_subscription.g.dart';

@UTCDateNullableConverter()
@JsonSerializable(includeIfNull: false)
class PushSubscription with EquatableMixin {
  final PushSubscriptionId? id;
  final String? deviceClientId;
  final String? url;
  final EncryptionKey? keys;
  final String? verificationCode;
  final UTCDate? expires;
  final List<String>? types;

  PushSubscription({
    this.id,
    this.deviceClientId,
    this.url,
    this.keys,
    this.verificationCode,
    this.expires,
    this.types,
  });

  factory PushSubscription.fromJson(Map<String, dynamic> json) =>
      _$PushSubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$PushSubscriptionToJson(this);

  @override
  List<Object?> get props => [
    id,
    deviceClientId,
    url,
    keys,
    verificationCode,
    expires,
    types,
  ];
}

class PushSubscriptionId extends Id {
  const PushSubscriptionId(String value) : super(value);
  factory PushSubscriptionId.fromJson(String json) => PushSubscriptionId(json);
}
