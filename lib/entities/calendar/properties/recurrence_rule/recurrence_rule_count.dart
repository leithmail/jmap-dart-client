import 'package:equatable/equatable.dart';

class RecurrenceRuleCount with EquatableMixin {
  final int value;

  RecurrenceRuleCount(this.value);

  @override
  List<Object?> get props => [value];
}
