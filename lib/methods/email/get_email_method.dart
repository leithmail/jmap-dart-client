import 'package:jmap_dart_client/api/api.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/email/argument/email_body_property.dart';
import 'package:jmap_dart_client/methods/email/argument/email_property.dart';
import 'package:jmap_dart_client/methods/email/get_email_response.dart';

class GetEmailMethod
    extends GetMethod<GetEmailResponse, ResultReference, EmailProperty>
    with EmptyResultReferences {
  GetEmailMethod({required super.accountId});

  final bodyProperties = ListSlot<EmailBodyProperty>(
    "bodyProperties",
    (v) => v.value,
  );
  final fetchTextBodyValues = PrimitiveSlot<bool>("fetchTextBodyValues");
  final fetchHTMLBodyValues = PrimitiveSlot<bool>("fetchHTMLBodyValues");
  final fetchAllBodyValues = PrimitiveSlot<bool>("fetchAllBodyValues");
  final maxBodyValueBytes = PrimitiveSlot<int>("maxBodyValueBytes");

  @override
  get slots => [
    ...super.slots,
    bodyProperties,
    fetchTextBodyValues,
    fetchHTMLBodyValues,
    fetchAllBodyValues,
    maxBodyValueBytes,
  ];

  @override
  MethodName get methodName => MethodName('Email/get');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapMail,
  ];

  @override
  GetEmailResponse responseFromJson(Map<String, dynamic> json) {
    return GetEmailResponse.fromJson(json);
  }
}
