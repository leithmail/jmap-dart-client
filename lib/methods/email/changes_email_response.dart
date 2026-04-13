import 'package:jmap_dart_client/api/method/response/changes_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'changes_email_response.g.dart';

@IdConverter()
@StateConverter()
@JsonSerializable(createToJson: false)
class ChangesEmailResponse extends ChangesResponse {
  ChangesEmailResponse(
    AccountId accountId,
    State oldState,
    State newState,
    bool hasMoreChanges,
    List<Id> created,
    List<Id> updated,
    List<Id> destroyed,
  ) : super(
        accountId,
        oldState,
        newState,
        hasMoreChanges,
        created,
        updated,
        destroyed,
      );

  factory ChangesEmailResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangesEmailResponseFromJson(json);
}

class ChangesEmailResultReferences extends ResultReference {
  ChangesEmailResultReferences({
    required super.resultOf,
    required super.name,
    required super.path,
  });
}
