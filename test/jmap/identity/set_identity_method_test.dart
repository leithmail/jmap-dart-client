import 'package:jmap_dart_client/api/request_builder.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/identity/identity.dart';
import 'package:jmap_dart_client/methods/identity/set_identity_method.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  group('test to json set identity method', () {
    final expectedCreated = Identity(
      id: IdentityId(Id('bc6d7c78-672a-45e9-b0de-1dfd2699020a')),
    );

    test('set identity method and response parsing', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "Identity/set",
              {
                "accountId":
                    "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                "newState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "created": {
                  "dab246": {
                    "id": "bc6d7c78-672a-45e9-b0de-1dfd2699020a",
                    "mayDelete": true,
                  },
                },
              },
              "c0",
            ],
          ],
        },
        expectedBody: {
          "using": [
            "urn:ietf:params:jmap:core",
            "urn:ietf:params:jmap:submission",
          ],
          "methodCalls": [
            [
              "Identity/set",
              {
                "accountId":
                    "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                "create": {
                  "dab246": {
                    "name": "User B1",
                    "email": "userb@qa.open-paas.org",
                    "textSignature": "",
                    "htmlSignature":
                        "<body><div>Dat T. Vu <br>Mobile Engineer <br>LINAGORA VIETNAM <br>A: 8th Floor (Toong VPBank Tower, No. 5 Dien Bien Phu  Str., Ba Dinh Dist., Ha Noi <br>P: (+84) 366-769-439<br>E: tdvu@linagora.com</div></body>",
                  },
                },
              },
              "c0",
            ],
          ],
        },
      );

      final setIdentityMethod =
          SetIdentityMethod(
            AccountId(
              Id(
                '3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12',
              ),
            ),
          )..addCreates({
            Id('dab246'): Identity(
              name: 'User B1',
              email: 'userb@qa.open-paas.org',
              textSignature: Signature(''),
              htmlSignature: Signature(
                '<body><div>Dat T. Vu <br>Mobile Engineer <br>LINAGORA VIETNAM <br>A: 8th Floor (Toong VPBank Tower, No. 5 Dien Bien Phu  Str., Ba Dinh Dist., Ha Noi <br>P: (+84) 366-769-439<br>E: tdvu@linagora.com</div></body>',
              ),
            ),
          });

      final requestBuilder = RequestBuilder();
      final setIdentityInvocation = requestBuilder.addInvocation(
        setIdentityMethod,
      );
      final response = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );

      final setIdentityResponse = setIdentityInvocation.parseResponse(response);
      expect(
        setIdentityResponse.created![Id('dab246')]!.id,
        equals(expectedCreated.id),
      );
    });
  });
}
