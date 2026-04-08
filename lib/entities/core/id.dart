import 'package:equatable/equatable.dart';

class Id with EquatableMixin {
  final RegExp _idCharacterConstraint = RegExp(r'^[a-zA-Z0-9]+[a-zA-Z0-9-_]*$');
  final String value;

  Id(this.value) {
    if (value.isEmpty || value.length >= 255) {
      throw ArgumentError('invalid length');
    }
    if (!_idCharacterConstraint.hasMatch(value)) {
      throw ArgumentError('invalid characters');
    }
  }

  @override
  List<Object?> get props => [value];
}
