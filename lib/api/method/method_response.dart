import 'package:json_serializable_lints_annotation/json_serializable_lints_annotation.dart';
import 'package:meta/meta.dart';

@RequireFromJson()
@immutable
abstract class MethodResponse {}
