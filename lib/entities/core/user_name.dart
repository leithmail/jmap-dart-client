import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class UserName with EquatableMixin {
  final String value;

  UserName(this.value);

  @override
  List<Object?> get props => [value];
}
