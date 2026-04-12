import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/entities/core/id.dart';

abstract class CalendarEventReplyMethod<R extends MethodResponse>
    extends MethodRequiringAccountId<R> {
  CalendarEventReplyMethod(super.accountId, {required List<Id> blobIds}) {
    this.blobIds.set(blobIds);
  }

  final blobIds = ListArgumentSlot<Id>('blobIds', (v) => v.value);
  final language = PrimitiveArgumentSlot<String>('language');

  @override
  get slots => [...super.slots, blobIds, language];
}
