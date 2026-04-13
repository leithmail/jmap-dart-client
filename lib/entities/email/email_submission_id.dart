import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/email/email.dart';

class EmailSubmissionId with EquatableMixin {
  final Id id;

  EmailSubmissionId(this.id);

  @override
  String toString() {
    if (id is ReferenceId) {
      return id.toString();
    }
    return super.toString();
  }

  @override
  List<Object?> get props => [id];
}
