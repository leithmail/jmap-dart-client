import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/argument/property.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';

abstract class GetMethod<
  R extends MethodResponse,
  Q extends ResultReference,
  P extends Property
>
    extends MethodWithAccountId<R, Q> {
  final ids = ListSlot<Id>('ids', IdConverter().toJson);
  final properties = ListSlot<P>('properties', (v) => v.value);

  GetMethod({required super.accountId});

  @override
  get slots => [...super.slots, ids, properties];
}
