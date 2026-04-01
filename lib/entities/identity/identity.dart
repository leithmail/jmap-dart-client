import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/entities/email/email_address.dart';
import 'package:jmap_dart_client/src/converters/identities/identity_id_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/identities/signature_nullable_converter.dart';
import 'package:jmap_dart_client/src/converters/unsigned_int_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'identity.g.dart';

@UnsignedIntNullableConverter()
@IdentityIdNullableConverter()
@SignatureNullableConverter()
@JsonSerializable()
class Identity with EquatableMixin {
  @JsonKey(includeIfNull: false)
  final IdentityId? id;

  @JsonKey(includeIfNull: false)
  final String? description;

  @JsonKey(includeIfNull: false)
  final String? name;

  @JsonKey(includeIfNull: false)
  final String? email;

  @JsonKey(includeIfNull: false)
  final Set<EmailAddress>? bcc;

  @JsonKey(includeIfNull: false)
  final Set<EmailAddress>? replyTo;

  @JsonKey(includeIfNull: false)
  final Signature? textSignature;

  @JsonKey(includeIfNull: false)
  final Signature? htmlSignature;

  @JsonKey(includeIfNull: false)
  final bool? mayDelete;

  @JsonKey(includeIfNull: false)
  final UnsignedInt? sortOrder;

  Identity({
    this.id,
    this.description,
    this.name,
    this.email,
    this.bcc,
    this.replyTo,
    this.textSignature,
    this.htmlSignature,
    this.mayDelete,
    this.sortOrder,
  });

  factory Identity.fromJson(Map<String, dynamic> json) =>
      _$IdentityFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityToJson(this);

  @override
  List<Object?> get props => [
    id,
    description,
    name,
    email,
    bcc,
    replyTo,
    textSignature,
    htmlSignature,
    mayDelete,
    sortOrder,
  ];
}

class IdentityId with EquatableMixin {
  final Id id;

  IdentityId(this.id);

  @override
  List<Object?> get props => [id];
}

class Signature with EquatableMixin {
  final String value;

  Signature(this.value);

  @override
  List<Object?> get props => [value];
}
