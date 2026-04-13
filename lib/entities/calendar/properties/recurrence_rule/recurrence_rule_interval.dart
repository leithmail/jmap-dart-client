import 'package:equatable/equatable.dart';

class RecurrenceRuleInterval with EquatableMixin {
  final int value;

  RecurrenceRuleInterval(this.value);

  @override
  List<Object?> get props => [value];
}
