import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';

class RecurrenceRuleCount with EquatableMixin {
  final UnsignedInt value;

  RecurrenceRuleCount(this.value);

  @override
  List<Object?> get props => [value];
}
