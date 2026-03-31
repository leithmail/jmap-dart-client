import 'package:jmap_dart_client/api/jmap_request.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/core/utc_date.dart';
import 'package:jmap_dart_client/entities/vacation/vacation_id.dart';
import 'package:jmap_dart_client/entities/vacation/vacation_response.dart';
import 'package:jmap_dart_client/methods/vacation/get_vacation_method.dart';
import 'package:jmap_dart_client/methods/vacation/get_vacation_response.dart';
import 'package:jmap_dart_client/methods/vacation/set_vacation_method.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  group('test to json set vacation method', () {
    final expectedUpdated = VacationResponse(
      id: VacationId.singleton(),
      isEnabled: true,
      fromDate: UTCDate(DateTime.parse('2022-08-16T15:00:00.000Z')),
      textBody: 'Hello dab',
    );

    test('set vacation method and response parsing', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "VacationResponse/set",
              {
                "accountId":
                    "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                "newState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "updated": {"singleton": {}},
              },
              "c0",
            ],
            [
              "VacationResponse/get",
              {
                "accountId":
                    "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                "notFound": [],
                "state": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "list": [
                  {
                    "id": "singleton",
                    "isEnabled": true,
                    "fromDate": "2022-08-16T15:00:00.000Z",
                    "textBody": "Hello dab",
                  },
                ],
              },
              "c1",
            ],
          ],
        },
        expectedBody: {
          "using": [
            "urn:ietf:params:jmap:core",
            "urn:ietf:params:jmap:vacationresponse",
          ],
          "methodCalls": [
            [
              "VacationResponse/set",
              {
                "accountId":
                    "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                "update": {
                  "singleton": {
                    "isEnabled": true,
                    "fromDate": "2022-08-16T15:00:00.000Z",
                    "toDate": null,
                    "subject": null,
                    "textBody": "Hello dab",
                    "htmlBody": null,
                  },
                },
              },
              "c0",
            ],
            [
              "VacationResponse/get",
              {
                "accountId":
                    "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
              },
              "c1",
            ],
          ],
        },
      );

      final accountId = AccountId(
        Id('0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555'),
      );

      final processingInvocation = ProcessingInvocation();

      final setVacationMethod = SetVacationMethod(accountId)
        ..addUpdatesSingleton({
          VacationId.singleton().id: VacationResponse(
            isEnabled: true,
            fromDate: UTCDate(DateTime.parse('2022-08-16T15:00:00.000Z')),
            textBody: 'Hello dab',
          ),
        });

      final requestBuilder = JmapRequestBuilder(processingInvocation)
        ..invocation(setVacationMethod);

      final getVacationMethod = GetVacationMethod(accountId);
      final getVacationInvocation = requestBuilder.invocation(
        getVacationMethod,
      );

      final response = await requestBuilder.build().execute(
        httpMockClient,
        MockEndpointHttpClient.endpointUri,
      );

      final getVacationResponse = response.parse<GetVacationResponse>(
        getVacationInvocation.methodCallId,
        GetVacationResponse.deserialize,
      );

      expect(getVacationResponse.list, contains(expectedUpdated));
    });
  });
}
