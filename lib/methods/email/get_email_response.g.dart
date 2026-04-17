// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEmailResponse _$GetEmailResponseFromJson(Map<String, dynamic> json) =>
    GetEmailResponse(
      accountId: Id<Account>.fromJson(json['accountId'] as String),
      state: State<Email>.fromJson(json['state'] as String),
      list: (json['list'] as List<dynamic>)
          .map((e) => Email.fromJson(e as Map<String, dynamic>))
          .toList(),
      notFound: (json['notFound'] as List<dynamic>?)
          ?.map((e) => Id<Email>.fromJson(e as String))
          .toList(),
    );
