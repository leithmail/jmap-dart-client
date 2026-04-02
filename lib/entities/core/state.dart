import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class State with EquatableMixin {
  final String value;

  State(this.value);

  @override
  List<Object?> get props => [value];
}
