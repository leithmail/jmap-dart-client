import 'package:equatable/equatable.dart';

abstract class JmapException with EquatableMixin implements Exception {
  final String? message;

  JmapException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;
}
