import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class UnsignedInt with EquatableMixin {
  final int value;

  // UnsignedInt in range [0...2^53-1].
  UnsignedInt(this.value) {
    if (value < 0 || value >= 9007199254740992) {
      throw ArgumentError('value must be in range [0...2^53-1]');
    }
  }

  @override
  List<Object?> get props => [value];
}
