import 'package:jmap_dart_client/api/method/response/get_response.dart';
import 'package:jmap_dart_client/entities/thread/thread.dart';
import 'package:jmap_dart_client/src/converters/account_id_converter.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/state_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_thread_response.g.dart';

@AccountIdConverter()
@StateConverter()
@IdConverter()
@JsonSerializable(createToJson: false)
class GetThreadResponse extends GetResponse<Thread> {
  GetThreadResponse(super.accountId, super.state, super.list, super.notFound);

  factory GetThreadResponse.fromJson(Map<String, dynamic> json) =>
      _$GetThreadResponseFromJson(json);
}
