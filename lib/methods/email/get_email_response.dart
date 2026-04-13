import 'package:jmap_dart_client/api/method/response/get_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/src/converters/email_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_email_response.g.dart';

@EmailConverter()
@StateConverter()
@IdConverter()
@JsonSerializable(createToJson: false)
class GetEmailResponse extends GetResponse<Email> {
  GetEmailResponse(
    AccountId accountId,
    State state,
    List<Email> list,
    List<Id>? notFound,
  ) : super(accountId, state, list, notFound);

  factory GetEmailResponse.fromJson(Map<String, dynamic> json) =>
      _$GetEmailResponseFromJson(json);
}
