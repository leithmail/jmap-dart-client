import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/api/method/response/clear_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'clear_mailbox_response.g.dart';

@AccountIdConverter()
@JsonSerializable(createToJson: false)
class ClearMailboxResponse extends ClearResponse {
  ClearMailboxResponse(
    AccountId accountId,
    int? totalDeletedMessagesCount,
    SetError? notCleared,
  ) : super(accountId, totalDeletedMessagesCount, notCleared);

  factory ClearMailboxResponse.fromJson(Map<String, dynamic> json) =>
      _$ClearMailboxResponseFromJson(json);
}
