import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thread.g.dart';

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

typedef ThreadId = Id<Thread>;
