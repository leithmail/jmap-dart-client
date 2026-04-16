import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/argument/property.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/response/get_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/id.dart';

abstract class GetMethod<
  T,
  R extends GetResponse<T>,
  Q extends ResultReference,
  P extends Property
>
    extends MethodWithAccountId<R, Q> {
  final ids = ListSlot<Id<T>>('ids', (v) => v.value);
  final properties = ListSlot<P>('properties', (v) => v.value);

  GetMethod({required super.accountId});

  @override
  get slots => [...super.slots, ids, properties];
}
