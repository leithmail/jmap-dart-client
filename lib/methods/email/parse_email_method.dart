import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/request/parse_method.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/methods/email/get_email_method.dart';
import 'package:jmap_dart_client/methods/email/parse_email_response.dart';

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
  get requiredCapabilities => [
    ...super.requiredCapabilities,
    CapabilityIdentifier.jmapMail,
  ];

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
  ParseEmailResponse responseFromJson(Map<String, dynamic> json) {
    return ParseEmailResponse.fromJson(json);
  }
}
