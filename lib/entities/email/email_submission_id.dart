import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/api/request/reference_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';

class EmailSubmissionId with EquatableMixin {
  final Id id;

  EmailSubmissionId(this.id);

  @override
  String toString() {
    if (id is ReferenceId) {
      return '${(id as ReferenceId).prefix.value}${(id as ReferenceId).id.value}';
    }
    return super.toString();
  }

  @override
  List<Object?> get props => [id];
}
