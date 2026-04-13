import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/argument/property.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/id.dart';

abstract class ParseMethod<
  R extends MethodResponse,
  Q extends ResultReference,
  P extends Property
>
    extends MethodWithAccountId<R, Q> {
  final _blobIds = ListSlot<Id>('blobIds', (v) => v.value);
  final properties = ListSlot<P>('properties', (v) => v.value);

  ParseMethod({required super.accountId, required Argument<List<Id>> blobIds}) {
    _blobIds(blobIds);
  }

  @override
  get slots => [...super.slots, _blobIds, properties];
}
