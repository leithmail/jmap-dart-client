import 'package:equatable/equatable.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/email/email_header.dart';
import 'package:jmap_dart_client/src/converters/media_type_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_body_part.g.dart';

@MediaTypeNullableConverter()
@JsonSerializable(includeIfNull: false)
class EmailBodyPart with EquatableMixin {
  final EmailBodyPartId? partId;
  final BlobId? blobId;
  final int? size;
  final List<EmailHeader>? headers;
  final String? name;
  final MediaType? type;
  final String? charset;
  final String? disposition;
  final String? cid;
  final List<String>? language;
  final String? location;
  final List<EmailBodyPart>? subParts;

  EmailBodyPart({
    this.partId,
    this.blobId,
    this.size,
    this.headers,
    this.name,
    this.type,
    this.charset,
    this.disposition,
    this.cid,
    this.language,
    this.location,
    this.subParts,
  });

  factory EmailBodyPart.fromJson(Map<String, dynamic> json) =>
      _$EmailBodyPartFromJson(json);

  Map<String, dynamic> toJson() => _$EmailBodyPartToJson(this);

  @override
  List<Object?> get props => [
    partId,
    blobId,
    size,
    headers,
    name,
    type,
    charset,
    disposition,
    cid,
    language,
    location,
    subParts,
  ];
}

typedef EmailBodyPartId = Id<EmailBodyPart>;
