import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/parse_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/email/email_body_properties.dart';
import 'package:jmap_dart_client/methods/email/get_email_method.dart';
import 'package:jmap_dart_client/methods/email/parse_email_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/properties_converter.dart';
import 'package:jmap_dart_client/src/converters/unsigned_int_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parse_email_method.g.dart';

@AccountIdConverter()
@IdConverter()
@UnsignedIntNullableConverter()
@PropertiesConverter()
@JsonSerializable(includeIfNull: false)
class ParseEmailMethod extends ParseMethod<ParseEmailResponse>
    with
        OptionalEmailBodyProperties,
        OptionalFetchTextBodyValues,
        OptionalFetchHTMLBodyValues,
        OptionalFetchAllBodyValues,
        OptionalMaxBodyValueBytes {
  ParseEmailMethod(super.accountId, super.blobIds);

  @override
  MethodName get methodName => MethodName('Email/parse');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

  factory ParseEmailMethod.fromJson(Map<String, dynamic> json) =>
      _$ParseEmailMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ParseEmailMethodToJson(this);

  @override
  ParseEmailResponse responseFromJson(Map<String, dynamic> json) {
    return ParseEmailResponse.deserialize(json);
  }
}
