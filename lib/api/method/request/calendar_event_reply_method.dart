import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class CalendarEventReplyMethod extends MethodRequiringAccountId
    with OptionalLanguage {
  CalendarEventReplyMethod(super.accountId, {required this.blobIds});

  final List<Id> blobIds;
}

mixin OptionalLanguage {
  @JsonKey(includeIfNull: false)
  String? language;

  void addLanguage(String value) {
    language = value;
  }
}
