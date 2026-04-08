import 'package:equatable/equatable.dart';

class ReferencePrefix with EquatableMixin {
  static final defaultPrefix = ReferencePrefix('#');

  final String value;

  ReferencePrefix(this.value) {
    if (value.isEmpty || value.length >= 255) {
      throw ArgumentError('invalid length');
    }
  }

  @override
  List<Object?> get props => [value];
}
