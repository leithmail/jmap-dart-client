import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/properties/properties.dart';
import 'package:jmap_dart_client/api/request/reference_path.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class GetMethod<R extends MethodResponse>
    extends MethodRequiringAccountId<R>
    with
        OptionalIds,
        OptionalProperties,
        OptionalReferenceIds,
        OptionalReferenceProperties {
  GetMethod(AccountId accountId) : super(accountId);
}

abstract class GetMethodNoNeedAccountId<R extends MethodResponse>
    extends Method<R>
    with
        OptionalIds,
        OptionalProperties,
        OptionalReferenceIds,
        OptionalReferenceProperties {
  GetMethodNoNeedAccountId() : super();
}

mixin OptionalIds {
  @JsonKey(includeIfNull: false)
  Set<Id>? ids;

  void addIds(Set<Id> values) {
    ids ??= <Id>{};
    ids?.addAll(values);
  }
}

mixin OptionalReferenceIds {
  @JsonKey(name: '#ids', includeIfNull: false)
  ResultReference? referenceIds;

  void addReferenceIds(RequestInvocation invocation, ReferencePath path) {
    referenceIds = invocation.createResultReference(path);
  }
}

mixin OptionalProperties {
  @JsonKey(includeIfNull: false)
  Properties? properties = Properties.empty();

  void addProperties(Properties other) {
    properties = properties?.union(other);
  }
}

mixin OptionalReferenceProperties {
  @JsonKey(name: '#properties', includeIfNull: false)
  ResultReference? referenceProperties;

  void addReferenceProperties(ResultReference resultReferenceProperties) {
    referenceProperties = resultReferenceProperties;
  }
}
