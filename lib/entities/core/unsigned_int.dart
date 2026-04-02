import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quiver/check.dart';

@immutable
class UnsignedInt with EquatableMixin {
  final int value;

  // UnsignedInt in range [0...2^53-1].
  UnsignedInt(this.value) {
    checkArgument(value >= 0);
    checkArgument(value < 9007199254740992);
  }

  @override
  List<Object?> get props => [value];
}
