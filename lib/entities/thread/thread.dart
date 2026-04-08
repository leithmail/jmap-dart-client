import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/src/converters/email_id_converter.dart';
import 'package:jmap_dart_client/src/converters/thread_id_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thread.g.dart';

@ThreadIdConverter()
@EmailIdConverter()
@JsonSerializable(includeIfNull: false)
class Thread with EquatableMixin {
  final ThreadId id;
  final List<EmailId> emailIds;

  const Thread({required this.id, required this.emailIds});

  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);

  Map<String, dynamic> toJson() => _$ThreadToJson(this);

  @override
  List<Object?> get props => [id, emailIds];
}
