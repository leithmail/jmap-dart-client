import 'dart:convert';

import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:json_annotation/json_annotation.dart';

class RequestInvocationConverter
    implements JsonConverter<RequestInvocation, List<dynamic>> {
  const RequestInvocationConverter();

  @override
  RequestInvocation fromJson(List<dynamic> json) {
    return RequestInvocation(jsonDecode(json[1]), jsonDecode(json[2]));
  }

  @override
  List toJson(RequestInvocation object) {
    List<dynamic> list = List.empty(growable: true);
    list.add(object.method.methodName.value);
    list.add(object.method.toJson());
    list.add(object.methodCallId.value);
    return list;
  }
}
