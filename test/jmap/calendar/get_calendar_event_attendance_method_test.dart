import 'package:jmap_dart_client/api/errors/exceptions.dart';
import 'package:jmap_dart_client/api/errors/set_error.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request_builder.dart';
import 'package:jmap_dart_client/entities/calendar/calendar_event_attendance.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/methods/calendar/attendance/get_calendar_event_attendance_method.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  group('get calendar event attendance method test', () {
    final accountId = AccountId(Id('123abc'));
    final freeBlobId = Id('abc123');
    final busyBlobId = Id('def456');
    final notFoundBlobId = Id('ghi789');

    final methodCallId = MethodCallId('c0');

    test('should return CalendarEventAttendance '
        'when the method returns success', () async {
      // arrange
      final freeAttendance = CalendarEventAttendance(
        blobId: freeBlobId,
        eventAttendanceStatus: AttendanceStatus.accepted,
        isFree: true,
      );
      final busyAttendance = CalendarEventAttendance(
        blobId: busyBlobId,
        eventAttendanceStatus: AttendanceStatus.rejected,
        isFree: false,
      );
      final blobIds = [freeBlobId, busyBlobId, notFoundBlobId];
      final getCalendarEventAttendanceMethod = GetCalendarEventAttendanceMethod(
        accountId,
        blobIds,
      );
      final sampleRequest = {
        "using":
            getCalendarEventAttendanceMethod.requiredCapabilities
                .map((capability) => capability.value.toString())
                .toList()
              ..sort(),
        "methodCalls": [
          [
            getCalendarEventAttendanceMethod.methodName.value,
            {
              "accountId": accountId.id.value,
              "blobIds": blobIds.map((id) => id.value).toList(),
            },
            methodCallId.value,
          ],
        ],
      };
      final sampleResponse = {
        "sessionState": "abcdefghij",
        "methodResponses": [
          [
            "CalendarEventAttendance/get",
            {
              "accountId": accountId.id.value,
              "state": "state",
              "list": [freeAttendance.toJson(), busyAttendance.toJson()],
              "notFound": [notFoundBlobId.value],
              "notDone": {},
            },
            methodCallId.value,
          ],
        ],
      };
      final httpMockClient = HttpMockResponseClient(
        responseBody: sampleResponse,
        expectedBody: sampleRequest,
      );

      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        getCalendarEventAttendanceMethod,
        methodCallId: methodCallId,
      );

      requestBuilder.addUsings(
        getCalendarEventAttendanceMethod.requiredCapabilities,
      );
      // act
      final requestResponse = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final response = invocation.parse(requestResponse);
      // assert
      expect(response.accountId, equals(accountId));
      expect(response.list, equals([freeAttendance, busyAttendance]));
      expect(response.notFound, equals([notFoundBlobId]));
      expect(response.notDone?.isEmpty, isTrue);
    });

    test('should return notDone '
        'when blobId is invalid', () async {
      // arrange
      final blobId = Id('invalid');
      final getCalendarEventAttendanceMethod = GetCalendarEventAttendanceMethod(
        accountId,
        [blobId],
      );
      final sampleRequest = {
        "using":
            getCalendarEventAttendanceMethod.requiredCapabilities
                .map((capability) => capability.value.toString())
                .toList()
              ..sort(),
        "methodCalls": [
          [
            getCalendarEventAttendanceMethod.methodName.value,
            {
              "accountId": accountId.id.value,
              "blobIds": [blobId.value],
            },
            methodCallId.value,
          ],
        ],
      };
      final sampleResponse = {
        "sessionState": "abcdefghij",
        "methodResponses": [
          [
            "CalendarEventAttendance/get",
            {
              "accountId": accountId.id.value,
              "state": "state",
              "list": [],
              "notFound": [],
              "notDone": {
                blobId.value: SetError(SetError.invalidArguments).toJson(),
              },
            },
            methodCallId.value,
          ],
        ],
      };
      final httpMockClient = HttpMockResponseClient(
        responseBody: sampleResponse,
        expectedBody: sampleRequest,
      );

      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        getCalendarEventAttendanceMethod,
        methodCallId: methodCallId,
      );
      requestBuilder.addUsings(
        getCalendarEventAttendanceMethod.requiredCapabilities,
      );
      // act
      final requestResponse = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );
      final response = invocation.parse(requestResponse);

      // assert
      expect(response.accountId, equals(accountId));
      expect(response.list.isEmpty, isTrue);
      expect(response.notFound?.isEmpty, isTrue);
      expect(
        response.notDone?[blobId],
        equals(SetError(SetError.invalidArguments)),
      );
    });

    test('should return error '
        'when method returns error', () async {
      // arrange
      final blobId = Id('invalid');
      final getCalendarEventAttendanceMethod = GetCalendarEventAttendanceMethod(
        accountId,
        [blobId],
      );
      final sampleRequest = {
        "using":
            getCalendarEventAttendanceMethod.requiredCapabilities
                .map((capability) => capability.value.toString())
                .toList()
              ..sort(),
        "methodCalls": [
          [
            getCalendarEventAttendanceMethod.methodName.value,
            {
              "accountId": accountId.id.value,
              "blobIds": [blobId.value],
            },
            methodCallId.value,
          ],
        ],
      };
      final sampleResponse = {
        "sessionState": "abcdefghij",
        "methodResponses": [
          [
            "error",
            {"type": SetError.tooLarge.value},
            methodCallId.value,
          ],
        ],
      };
      final httpMockClient = HttpMockResponseClient(
        responseBody: sampleResponse,
        expectedBody: sampleRequest,
      );

      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        getCalendarEventAttendanceMethod,
        methodCallId: methodCallId,
      );

      // act
      final response = (await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      ));

      // assert
      expect(
        () => invocation.parse(response),
        throwsA(isA<JmapMethodErrorException>()),
      );
    });
  });
}
