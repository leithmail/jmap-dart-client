import 'package:equatable/equatable.dart';

class Properties with EquatableMixin {
  final Set<String> value;

  Properties(this.value);

  static Properties empty() => Properties(<String>{});

  Properties union(Properties other) => Properties(value.union(other.value));

  Properties removeAll(Properties other) =>
      Properties(value..removeAll(other.value));

  @override
  List<Object?> get props => [value];
}
