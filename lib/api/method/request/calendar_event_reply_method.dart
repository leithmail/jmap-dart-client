import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/id.dart';

abstract class CalendarEventReplyMethod<R extends MethodResponse>
    extends MethodRequiringAccountId<R>
    with OptionalLanguage {
  CalendarEventReplyMethod(super.accountId, {required List<Id> blobIds}) {
    this.blobIds.set(blobIds);
  }

  final blobIds = ArgumentSlot<List<Id>>(
    'blobIds',
    (v) => v.map((e) => e.value).toList(),
  );

  @override
  get slots => [...super.slots, blobIds];
}

mixin OptionalLanguage<R extends MethodResponse, F extends ResultReference>
    on Method<R, F> {
  final language = ArgumentSlot<String?>('language', (v) => v);

  void addLanguage(String value) {
    language.set(value);
  }

  @override
  get slots => [...super.slots, language];
}
