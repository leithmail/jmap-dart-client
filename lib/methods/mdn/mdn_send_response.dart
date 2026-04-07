import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/api/method/response/send_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/mdn/mdn.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';

class MDNSendResponse extends SendResponse<MDN> {
  MDNSendResponse(
    AccountId accountId, {
    Map<Id, MDN>? sent,
    Map<Id, SetError>? notSent,
  }) : super(accountId, sent: sent, notSent: notSent);

  static MDNSendResponse deserialize(Map<String, dynamic> json) {
    return MDNSendResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      sent: (json['sent'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          MDN.fromJson(value as Map<String, dynamic>),
        ),
      ),
      notSent: (json['notSent'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          const IdConverter().fromJson(key),
          SetError.fromJson(value),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [accountId, sent, notSent];
}
