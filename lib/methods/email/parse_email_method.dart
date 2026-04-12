import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/parse_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/email/email_body_properties.dart';
import 'package:jmap_dart_client/methods/email/parse_email_response.dart';

class ParseEmailMethod extends ParseMethod<ParseEmailResponse, ResultReference>
    with EmptyResultReferences {
  ParseEmailMethod({required super.accountId, required super.blobIds});

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
  MethodName get methodName => MethodName('Email/parse');

  @override
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapMail,
  ];

  @override
  ParseEmailResponse responseFromJson(Map<String, dynamic> json) {
    return ParseEmailResponse.fromJson(json);
  }
}
