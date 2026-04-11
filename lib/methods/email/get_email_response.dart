import 'package:jmap_dart_client/api/method/argument/sort/comparator.dart';
import 'package:jmap_dart_client/api/method/response/get_response.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/state.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/entities/email/email_comparator_property.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/email_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:jmap_dart_client/src/extensions/string_extension.dart';
import 'package:jmap_dart_client/src/extensions/unsigned_int_extension.dart';
import 'package:jmap_dart_client/src/extensions/utc_date_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_email_response.g.dart';

@EmailConverter()
@StateConverter()
@AccountIdConverter()
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

  void sortEmails(Comparator comparator) {
    list.sort((email1, email2) {
      if (comparator.property == EmailComparatorProperty.receivedAt) {
        return email1.receivedAt.compareToSort(
          email2.receivedAt,
          comparator.isAscending,
        );
      } else if (comparator.property == EmailComparatorProperty.sentAt) {
        return email1.sentAt.compareToSort(
          email2.sentAt,
          comparator.isAscending,
        );
      } else if (comparator.property == EmailComparatorProperty.subject) {
        return email1.subject.compareToSort(
          email2.subject,
          comparator.isAscending,
        );
      } else if (comparator.property == EmailComparatorProperty.size) {
        return email1.size.compareToSort(email2.size, comparator.isAscending);
      } else {
        return 0;
      }
    });
  }
}
