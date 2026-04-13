import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/email/email_address.dart';
import 'package:jmap_dart_client/src/converters/identities/signature_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'identity.g.dart';

@SignatureNullableConverter()
@JsonSerializable(includeIfNull: false)
class Identity with EquatableMixin {
  final IdentityId? id;
  final String? description;
  final String? name;
  final String? email;
  final List<EmailAddress>? bcc;
  final List<EmailAddress>? replyTo;
  final Signature? textSignature;
  final Signature? htmlSignature;
  final bool? mayDelete;
  final int? sortOrder;

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

class IdentityId extends Id {
  const IdentityId(String value) : super(value);
  factory IdentityId.fromJson(String json) => IdentityId(json);
}

class Signature with EquatableMixin {
  final String value;

  Signature(this.value);

  @override
  List<Object?> get props => [value];
}
