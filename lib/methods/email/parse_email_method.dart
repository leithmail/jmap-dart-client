import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/entities.dart';
import 'package:jmap_dart_client/methods/email/argument/email_body_property.dart';
import 'package:jmap_dart_client/methods/email/argument/email_property.dart';
import 'package:jmap_dart_client/methods/email/parse_email_response.dart';

class ParseEmailMethod
    extends MethodWithAccountId<ParseEmailResponse, ResultReference>
    with EmptyResultReferences {
  ParseEmailMethod({
    required super.accountId,
    required Argument<List<BlobId>> blobIds,
  }) {
    _blobIds(blobIds);
  }

  final _blobIds = ListSlot<BlobId>('blobIds', (v) => v.value);
  final properties = ListSlot<EmailProperty>('properties', (v) => v.value);
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
    _blobIds,
    properties,
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
