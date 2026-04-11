import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/argument/properties/properties.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/properties_converter.dart';

abstract class GetMethod<R extends MethodResponse>
    extends MethodRequiringAccountId<R>
    with OptionalIds, OptionalProperties {
  GetMethod(AccountId accountId) : super(accountId);
}

abstract class GetMethodNoNeedAccountId<R extends MethodResponse>
    extends Method<R, ResultReference>
    with OptionalIds, OptionalProperties {
  GetMethodNoNeedAccountId() : super();

  @override
  ResultReference resultReference(MethodCallId resultOf) =>
      resultReferenceDefault(resultOf);
}

mixin OptionalIds<R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  final ids = ArgumentSlot<Set<Id>?>(
    'ids',
    (v) => v?.map(const IdConverter().toJson).toList(),
  );

  @override
  get slots => [...super.slots, ids];
}

mixin OptionalProperties<R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  final properties = ArgumentSlot<Properties?>(
    'properties',
    (v) => PropertiesConverter().toJson(v),
  );

  @override
  get slots => [...super.slots, properties];
}
