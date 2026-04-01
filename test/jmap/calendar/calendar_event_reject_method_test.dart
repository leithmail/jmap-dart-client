import 'package:jmap_dart_client/api/method/request/calendar_event_reply_method.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request_builder.dart';
import 'package:jmap_dart_client/entities/calendar/properties/event_id.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/errors/set_error.dart';
import 'package:jmap_dart_client/methods/calendar/reply/calendar_event_reject_method.dart';
import 'package:jmap_dart_client/methods/calendar/reply/calendar_event_reject_response.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  final accountId = AccountId(Id('123abc'));
  final successBlobId = Id('abc123');
  final failureBlobId = Id('def456');
  final notFoundBlobId = Id('ghi789');
  final blobIds = [successBlobId, failureBlobId, notFoundBlobId];
  final methodCallId = MethodCallId('c0');
  final setErrorFixture = SetError(SetError.invalidPatch, description: '');

  Map<String, dynamic> constructData(CalendarEventReplyMethod method) => {
    "using":
        method.requiredCapabilities
            .map((capability) => capability.value.toString())
            .toList()
          ..sort(),
    "methodCalls": [
      [
        method.methodName.value,
        {
          "accountId": accountId.id.value,
          "blobIds": blobIds.map((id) => id.value).toList(),
        },
        methodCallId.value,
      ],
    ],
  };

  Map<String, dynamic> constructResponse(CalendarEventReplyMethod method) => {
    "sessionState": "abcdefghij",
    "methodResponses": [
      [
        method.methodName.value,
        {
          "accountId": accountId.id.value,
          "rejected": [successBlobId.value],
          "notRejected": {failureBlobId.value: setErrorFixture},
          "notFound": [notFoundBlobId.value],
        },
        methodCallId.value,
      ],
    ],
  };

  group('calendar event reject method', () {
    final method = CalendarEventRejectMethod(accountId, blobIds: blobIds);

    test('should succeed with success blob data, '
        'and fail with failure blob data '
        'and not found with not found blob data', () async {
      // arrange
      final httpMockClient = HttpMockResponseClient(
        responseBody: constructResponse(method),
        expectedBody: constructData(method),
      );

      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.invocation(
        method,
        methodCallId: methodCallId,
      );

      // act
      final response =
          (await requestBuilder.build().execute(
            httpMockClient,
            MockEndpointHttpClient.endpointUri,
          )).parse<CalendarEventRejectResponse>(
            invocation.methodCallId,
            CalendarEventRejectResponse.deserialize,
          );

      // assert
      expect(response.rejected, equals([EventId(successBlobId.value)]));
      expect(response.notRejected?.keys.toList(), equals([failureBlobId]));
      expect(response.notFound, equals([notFoundBlobId]));
    });
  });
}
