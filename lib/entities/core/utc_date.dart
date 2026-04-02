import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class UTCDate with EquatableMixin {
  final DateTime value;

  UTCDate(this.value);

  @override
  List<Object?> get props => [value];
}
