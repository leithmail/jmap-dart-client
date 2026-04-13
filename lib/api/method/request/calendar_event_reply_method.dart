import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/id.dart';

abstract class CalendarEventReplyMethod<
  R extends MethodResponse,
  Q extends ResultReference
>
    extends MethodWithAccountId<R, Q> {
  CalendarEventReplyMethod({
    required super.accountId,
    required Argument<List<Id>> blobIds,
  }) {
    _blobIds(blobIds);
  }

  final _blobIds = ListSlot<Id>('blobIds', (v) => v.value);
  final language = PrimitiveSlot<String>('language');

  @override
  get slots => [...super.slots, _blobIds, language];
}
