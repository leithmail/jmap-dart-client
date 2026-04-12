import 'package:jmap_dart_client/api/api.dart';
import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/email/email_body_properties.dart';
import 'package:jmap_dart_client/methods/email/get_email_response.dart';

class GetEmailMethod extends GetMethod<GetEmailResponse, ResultReference>
    with EmptyResultReferences {
  GetEmailMethod({required super.accountId});

  final bodyProperties = ArgumentSlot<EmailBodyProperties>(
    "bodyProperties",
    (v) => v.toJson(),
  );
  final fetchTextBodyValues = PrimitiveArgumentSlot<bool>(
    "fetchTextBodyValues",
  );
  final fetchHTMLBodyValues = PrimitiveArgumentSlot<bool>(
    "fetchHTMLBodyValues",
  );
  final fetchAllBodyValues = PrimitiveArgumentSlot<bool>("fetchAllBodyValues");
  final maxBodyValueBytes = PrimitiveArgumentSlot<int>("maxBodyValueBytes");

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
