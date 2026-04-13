import 'package:jmap_dart_client/entities/core/id.dart';

class AccountId extends Id {
  const AccountId(String value) : super(value);

  factory AccountId.fromJson(String json) => AccountId(json);
}
