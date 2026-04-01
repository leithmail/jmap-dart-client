import 'package:jmap_dart_client/api/method/response/clear_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/errors/set_error.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/unsigned_int_nullable_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'clear_mailbox_response.g.dart';

@JsonSerializable(
  includeIfNull: false,
  createToJson: false,
  converters: [AccountIdConverter(), UnsignedIntNullableConverter()],
)
class ClearMailboxResponse extends ClearResponse {
  ClearMailboxResponse(
    AccountId accountId,
    UnsignedInt? totalDeletedMessagesCount,
    SetError? notCleared,
  ) : super(accountId, totalDeletedMessagesCount, notCleared);

  static ClearMailboxResponse deserialize(Map<String, dynamic> json) =>
      _$ClearMailboxResponseFromJson(json);

  @override
  List<Object?> get props => [accountId, totalDeletedMessagesCount, notCleared];
}
