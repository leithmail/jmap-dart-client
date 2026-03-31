import 'package:jmap_dart_client/api/capabilities_converter.dart';
import 'package:jmap_dart_client/entities/core/account.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/src/converters/account_name_converter.dart';

class AccountConverter {
  const AccountConverter();

  MapEntry<AccountId, Account> convert(
    String key,
    dynamic value,
    CapabilitiesConverter converter,
  ) {
    final accountId = AccountId(Id(key));
    final account = accountFromJson(value, converter);
    return MapEntry(accountId, account);
  }

  Account accountFromJson(
    Map<String, dynamic> json,
    CapabilitiesConverter converter,
  ) {
    return Account(
      name: const AccountNameConverter().fromJson(json['name'] as String),
      isPersonal: json['isPersonal'] as bool,
      isReadOnly: json['isReadOnly'] as bool,
      accountCapabilities: (json['accountCapabilities'] as Map<String, dynamic>)
          .map((key, value) => converter.convert(key, value)),
    );
  }
}
