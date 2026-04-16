import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class UTCDate with EquatableMixin {
  final DateTime value;

  UTCDate(this.value);

  @override
  List<Object?> get props => [value];

  String toJson() => value.toUtc().toIso8601String();
  factory UTCDate.fromJson(String value) => UTCDate(DateTime.parse(value));
}
