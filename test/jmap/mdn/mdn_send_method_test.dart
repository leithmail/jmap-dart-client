import 'package:jmap_dart_client/api/jmap_request.dart';
import 'package:jmap_dart_client/api/request/patch_object.dart';
import 'package:jmap_dart_client/api/request/reference_id.dart';
import 'package:jmap_dart_client/api/request/reference_prefix.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/email/email.dart';
import 'package:jmap_dart_client/entities/email/email_submission_id.dart';
import 'package:jmap_dart_client/entities/email/keyword_identifier.dart';
import 'package:jmap_dart_client/entities/identity/identity.dart';
import 'package:jmap_dart_client/entities/mdn/disposition.dart';
import 'package:jmap_dart_client/entities/mdn/mdn.dart';
import 'package:jmap_dart_client/methods/mdn/mdn_send_method.dart';
import 'package:jmap_dart_client/methods/mdn/mdn_send_response.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  group('Test to json mdn send method', () {
    final expectedResult = MDN(
      originalRecipient:
          'rfc822; firstname23.surname23@upn.integration-open-paas.org',
      finalRecipient:
          'rfc822; firstname23.surname23@upn.integration-open-paas.org',
      includeOriginalMessage: false,
    );

    test('MDNSend method and response parsing', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "MDN/send",
              {
                "accountId":
                    "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                "sent": {
                  "k1546": {
                    "originalRecipient":
                        "rfc822; firstname23.surname23@upn.integration-open-paas.org",
                    "finalRecipient":
                        "rfc822; firstname23.surname23@upn.integration-open-paas.org",
                    "includeOriginalMessage": false,
                  },
                },
              },
              "c0",
            ],
            [
              "Email/set",
              {
                "accountId":
                    "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                "oldState": "324b8570-4486-11ed-b412-4700d9090322",
                "newState": "324b8570-4486-11ed-b412-4700d9090322",
                "updated": {"31ed5fe0-4486-11ed-b412-4700d9090322": null},
              },
              "c0",
            ],
          ],
        },
        expectedBody: {
          "using": [
            "urn:ietf:params:jmap:core",
            "urn:ietf:params:jmap:mail",
            "urn:ietf:params:jmap:mdn",
          ],
          "methodCalls": [
            [
              "MDN/send",
              {
                "accountId":
                    "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                "send": {
                  "k1546": {
                    "forEmailId": "31ed5fe0-4486-11ed-b412-4700d9090322",
                    "subject": "Subject MDN/send",
                    "textBody": "Hello MDN/send",
                    "disposition": {
                      "actionMode": "manual-action",
                      "sendingMode": "mdn-sent-manually",
                      "type": "displayed",
                    },
                  },
                },
                "identityId": "9ba9d77b-fbc8-4495-877d-d1261c25261f",
                "onSuccessUpdateEmail": {
                  "#k1546": {"keywords/\$mdnsent": true},
                },
              },
              "c0",
            ],
          ],
        },
      );

      final mdnSendMethod =
          MDNSendMethod(
            AccountId(
              Id(
                '0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555',
              ),
            ),
            {
              Id('k1546'): MDN(
                forEmailId: EmailId(Id('31ed5fe0-4486-11ed-b412-4700d9090322')),
                subject: 'Subject MDN/send',
                textBody: 'Hello MDN/send',
                disposition: Disposition(
                  ActionMode.manual,
                  SendingMode.manually,
                  DispositionType.displayed,
                ),
              ),
            },
            IdentityId(Id('9ba9d77b-fbc8-4495-877d-d1261c25261f')),
          )..addOnSuccessUpdateEmail({
            EmailSubmissionId(
              ReferenceId(ReferencePrefix.defaultPrefix, Id('k1546')),
            ): PatchObject({
              KeyWordIdentifier.mdnSent.toPatchObjectJson(): true,
            }),
          });

      final requestBuilder = JmapRequestBuilder(ProcessingInvocation());
      final mdnSendInvocation = requestBuilder.invocation(mdnSendMethod);
      final response = await requestBuilder.build().execute(
        httpMockClient,
        MockEndpointHttpClient.endpointUri,
      );

      final mdnSendResponse = response.parse<MDNSendResponse>(
        mdnSendInvocation.methodCallId,
        MDNSendResponse.deserialize,
      );

      expect(mdnSendResponse.sent![Id('k1546')]!, equals(expectedResult));
    });
  });
}
