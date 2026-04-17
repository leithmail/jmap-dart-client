import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/request/patch_object.dart';
import 'package:jmap_dart_client/api/request_builder.dart';
import 'package:jmap_dart_client/entities/core/account.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/identity/identity.dart';
import 'package:jmap_dart_client/methods/identity/set_identity_method.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  group('test to json set identity method', () {
    final expectedCreated = Identity(
      name: "Test",
      id: IdentityId('5ccf6d7b-77e8-467a-9064-9f7ccfb19e86'),
      email: 'test@test.com',
    );

    test('create new identity with response parsing', () async {
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "Identity/set",
              {
                "accountId":
                    "4603645929458bf671aca134b890cbb8ac4a0d297640fsdefe9230ea28daa0b1",
                "newState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "created": {
                  "dab246": {
                    "name": "Test",
                    "email": "test@test.com",
                    "id": "5ccf6d7b-77e8-467a-9064-9f7ccfb19e86",
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
                    "4603645929458bf671aca134b890cbb8ac4a0d297640fsdefe9230ea28daa0b1",
                "create": {
                  "dab246": {
                    "name": "User B23",
                    "email": "lol@gmail.com",
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
            accountId: Val(
              AccountId(
                '4603645929458bf671aca134b890cbb8ac4a0d297640fsdefe9230ea28daa0b1',
              ),
            ),
          )..create(
            Val({
              IdentityCreationId('dab246'): Identity(
                name: 'User B23',
                email: 'lol@gmail.com',
                textSignature: '',
                htmlSignature:
                    '<body><div>Dat T. Vu <br>Mobile Engineer <br>LINAGORA VIETNAM <br>A: 8th Floor (Toong VPBank Tower, No. 5 Dien Bien Phu  Str., Ba Dinh Dist., Ha Noi <br>P: (+84) 366-769-439<br>E: tdvu@linagora.com</div></body>',
              ),
            }),
          );

      final requestBuilder = RequestBuilder();
      final setIdentityInvocation = requestBuilder.addInvocation(
        setIdentityMethod,
      );
      final response =
          await (requestBuilder
                ..addUsings(setIdentityMethod.requiredCapabilities))
              .build()
              .execute(httpMockClient, HttpMockResponseClient.defaultUri);

      final setIdentityResponse = setIdentityInvocation.parseResponse(response);
      expect(
        setIdentityResponse.created![IdentityCreationId('dab246')]!.id,
        equals(expectedCreated.id),
      );
    });
  });

  group(
    'test increase of old default identity request and create new identity request',
    () {
      final expectedCreated = Identity(
        id: IdentityId('5ccf6d7b-77e8-467a-9064-9f7ccfb19e12'),
        name: 'User B23',
        email: 'userb23@test.com',
      );

      test(
        'test increase of old default identity request and create new identity request',
        () async {
          final httpMockClient = HttpMockResponseClient(
            responseBody: {
              "sessionState": "2c9f1b12-b35a-43e6-9af2-0106f123a943",
              "methodResponses": [
                [
                  "Identity/set",
                  {
                    "accountId":
                        "4603645929458bf671aca134b890cbb8ac4a0d297640fsdefe9230ea28daa0b1",
                    "newState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                    "created": {
                      "xyz123": {
                        "name": "User B23",
                        "email": "userb23@test.com",
                        "id": "5ccf6d7b-77e8-467a-9064-9f7ccfb19e12",
                        "mayDelete": true,
                      },
                    },
                    "updated": {"5ccf6d7b-77e8-467a-9064-9f7cc1234512": {}},
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
                        "4603645929458bf671aca134b890cbb8ac4a0d297640fsdefe9230ea28daa0b1",
                    "create": {
                      "xyz123": {
                        "id": "5ccf6d7b-77e8-467a-9064-9f7ccfb19e12",
                        "name": "User B23",
                        "email": "lol@gmail.com",
                      },
                    },
                    "update": {
                      "c6ba359f-94a8-4ee9-b515-6bd2d9698618": {
                        "name": "New Name",
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
                  accountId: Val(
                    AccountId(
                      '4603645929458bf671aca134b890cbb8ac4a0d297640fsdefe9230ea28daa0b1',
                    ),
                  ),
                )
                ..create(
                  Val({
                    IdentityCreationId('xyz123'): Identity(
                      id: IdentityId("5ccf6d7b-77e8-467a-9064-9f7ccfb19e12"),
                      name: 'User B23',
                      email: 'lol@gmail.com',
                    ),
                  }),
                )
                ..update(
                  Val({
                    Id("c6ba359f-94a8-4ee9-b515-6bd2d9698618"): PatchObject({
                      "name": "New Name",
                    }),
                  }),
                );

          final requestBuilder = RequestBuilder();
          final setIdentityInvocation = requestBuilder.addInvocation(
            setIdentityMethod,
          );
          final response =
              await (requestBuilder
                    ..addUsings(setIdentityMethod.requiredCapabilities))
                  .build()
                  .execute(httpMockClient, HttpMockResponseClient.defaultUri);

          final setIdentityResponse = setIdentityInvocation.parseResponse(
            response,
          );

          expect(
            setIdentityResponse.created![IdentityCreationId('xyz123')]!.id,
            equals(expectedCreated.id),
          );
          expect(
            setIdentityResponse.updated![IdentityId(
              '5ccf6d7b-77e8-467a-9064-9f7cc1234512',
            )],
            equals(Identity()),
          );
        },
      );
    },
  );
}
