import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/entities/email/email_body_properties.dart';
import 'package:jmap_dart_client/methods/email/get_email_response.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/properties_converter.dart';
import 'package:jmap_dart_client/src/converters/unsigned_int_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_email_method.g.dart';

@UnsignedIntNullableConverter()
@IdConverter()
@AccountIdConverter()
@PropertiesConverter()
@JsonSerializable(explicitToJson: true)
class GetEmailMethod extends GetMethod<GetEmailResponse>
    with
        OptionalEmailBodyProperties,
        OptionalFetchTextBodyValues,
        OptionalFetchHTMLBodyValues,
        OptionalFetchAllBodyValues,
        OptionalMaxBodyValueBytes {
  GetEmailMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('Email/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

  factory GetEmailMethod.fromJson(Map<String, dynamic> json) =>
      _$GetEmailMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetEmailMethodToJson(this);

  @override
  GetEmailResponse deserializeResponse(Map<String, dynamic> json) {
    return GetEmailResponse.deserialize(json);
  }
}

mixin OptionalEmailBodyProperties {
  @JsonKey(includeIfNull: false)
  EmailBodyProperties? bodyProperties;

  void addEmailBodyProperties(EmailBodyProperties value) {
    bodyProperties = value;
  }
}

mixin OptionalFetchTextBodyValues {
  @JsonKey(includeIfNull: false)
  bool? fetchTextBodyValues;

  void addFetchTextBodyValues(bool value) {
    fetchTextBodyValues = value;
  }
}

mixin OptionalFetchHTMLBodyValues {
  @JsonKey(includeIfNull: false)
  bool? fetchHTMLBodyValues;

  void addFetchHTMLBodyValues(bool value) {
    fetchHTMLBodyValues = value;
  }
}

mixin OptionalFetchAllBodyValues {
  @JsonKey(includeIfNull: false)
  bool? fetchAllBodyValues;

  void addFetchAllBodyValues(bool value) {
    fetchAllBodyValues = value;
  }
}

mixin OptionalMaxBodyValueBytes {
  @JsonKey(includeIfNull: false)
  UnsignedInt? maxBodyValueBytes;

  void addMaxBodyValueBytes(UnsignedInt value) {
    maxBodyValueBytes = value;
  }
}
