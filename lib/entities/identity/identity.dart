import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/email/email_address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'identity.g.dart';

@JsonSerializable(includeIfNull: false)
class Identity with EquatableMixin {
  final IdentityId? id;
  final String name;
  final String email;
  final List<EmailAddress>? replyTo;
  final List<EmailAddress>? bcc;
  final String textSignature;
  final String htmlSignature;
  final bool? mayDelete;

  factory Identity.fromJson(Map<String, dynamic> json) =>
      _$IdentityFromJson(json);

  Identity({
    this.id,
    required this.name,
    required this.email,
    required this.replyTo,
    required this.bcc,
    required this.textSignature,
    required this.htmlSignature,
    this.mayDelete,
  });

  Map<String, dynamic> toJson() => _$IdentityToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    bcc,
    replyTo,
    textSignature,
    htmlSignature,
    mayDelete,
  ];
}

typedef IdentityId = Id<Identity>;
