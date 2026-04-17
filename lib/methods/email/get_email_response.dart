import 'package:jmap_dart_client/api/method/response/get_response.dart';
import 'package:jmap_dart_client/entities/core/account.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_email_response.g.dart';

@JsonSerializable(createToJson: false)
class GetEmailResponse extends GetResponse<Email> {
  GetEmailResponse({
    required super.accountId,
    required super.state,
    required super.list,
    super.notFound,
  });
  factory GetEmailResponse.fromJson(Map<String, dynamic> json) =>
      _$GetEmailResponseFromJson(json);
}
