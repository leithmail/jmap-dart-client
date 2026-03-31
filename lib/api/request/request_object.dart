import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request/require_method_call.dart';
import 'package:jmap_dart_client/api/request/require_using.dart';
import 'package:jmap_dart_client/entities/capability/capability_identifier.dart';
import 'package:jmap_dart_client/src/converters/capability_identifier_converter.dart';
import 'package:jmap_dart_client/src/converters/request_invocation_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_object.g.dart';

@CapabilityIdentifierConverter()
@RequestInvocationConverter()
@JsonSerializable()
class RequestObject with EquatableMixin {
  final Set<CapabilityIdentifier> using;
  final List<RequestInvocation> methodCalls;

  RequestObject(this.using, this.methodCalls);

  @override
  List<Object> get props => [using, methodCalls];

  Map<String, dynamic> toJson() => _$RequestObjectToJson(this);

  static RequestObjectBuilder builder() {
    return RequestObjectBuilder();
  }
}

class RequestObjectBuilder with RequiredUsing, RequireMethodCall {
  RequestObject build() {
    final sortedCapabilities = SplayTreeSet<CapabilityIdentifier>(
      (a, b) => a.value.toString().compareTo(b.value.toString()),
    )..addAll(capabilitiesBuilder.build());

    return RequestObject(
      sortedCapabilities,
      invocationsBuilder.build().asList(),
    );
  }
}
