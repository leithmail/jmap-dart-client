import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/method/request/get_method.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/capability_identifier.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/entities/email/email_body_properties.dart';
import 'package:jmap_dart_client/methods/email/get_email_response.dart';

class GetEmailMethod extends GetMethod<GetEmailResponse>
    with
        OptionalEmailBodyProperties,
        OptionalFetchTextBodyValues,
        OptionalFetchHTMLBodyValues,
        OptionalFetchAllBodyValues,
        OptionalMaxBodyValueBytes {
  GetEmailMethod(AccountId accountId) : super(accountId);

  @override
  MethodName methodName() => MethodName('Email/get');

  @override
  Set<CapabilityIdentifier> requiredCapabilities() => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

  @override
  GetEmailResponse responseFromJson(Map<String, dynamic> json) {
    return GetEmailResponse.fromJson(json);
  }
}

mixin OptionalEmailBodyProperties<
  R extends MethodResponse,
  F extends ResultReference
>
    on Method<R, F> {
  final bodyProperties = ArgumentSlot<EmailBodyProperties?>(
    "bodyProperties",
    (v) => v?.toJson(),
  );

  @override
  get slots => [...super.slots, bodyProperties];
}

mixin OptionalFetchTextBodyValues<
  R extends MethodResponse,
  F extends ResultReference
>
    on Method<R, F> {
  final fetchTextBodyValues = ArgumentSlot<bool?>(
    "fetchTextBodyValues",
    (v) => v,
  );

  @override
  get slots => [...super.slots, fetchTextBodyValues];
}

mixin OptionalFetchHTMLBodyValues<
  R extends MethodResponse,
  F extends ResultReference
>
    on Method<R, F> {
  final fetchHTMLBodyValues = ArgumentSlot<bool?>(
    "fetchHTMLBodyValues",
    (v) => v,
  );

  @override
  get slots => [...super.slots, fetchHTMLBodyValues];
}

mixin OptionalFetchAllBodyValues<
  R extends MethodResponse,
  F extends ResultReference
>
    on Method<R, F> {
  final fetchAllBodyValues = ArgumentSlot<bool?>(
    "fetchAllBodyValues",
    (v) => v,
  );

  @override
  get slots => [...super.slots, fetchAllBodyValues];
}

mixin OptionalMaxBodyValueBytes<
  R extends MethodResponse,
  F extends ResultReference
>
    on Method<R, F> {
  final maxBodyValueBytes = ArgumentSlot<UnsignedInt?>(
    "maxBodyValueBytes",
    (v) => v?.value,
  );

  @override
  get slots => [...super.slots, maxBodyValueBytes];
}
