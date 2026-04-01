import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request_builder.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/email/public_asset.dart';
import 'package:jmap_dart_client/entities/identity/identity.dart';
import 'package:jmap_dart_client/methods/email/get_public_asset_method.dart';
import 'package:test/test.dart';

import '../../helpers/http_mocks.dart';

void main() {
  final accountId = AccountId(Id('123abc'));
  final identityId = IdentityId(Id('some-identity-id'));
  final methodCallId = MethodCallId('c0');
  final publicAsset = PublicAsset(
    id: Id('abc123'),
    blobId: Id('def456'),
    size: 123,
    contentType: 'image/jpeg',
    publicURI: 'http://domain.com/public/abc123',
    identityIds: {identityId: true},
  );

  group('get public asset method test:', () {
    test(
      'should return expected PublicAsset '
      'when call method PublicAsset/get with exist public asset id',
      () async {
        // arrange
        final getPublicAssetMethod = GetPublicAssetMethod(accountId)
          ..addIds({publicAsset.id!});
        final httpMockClient = HttpMockResponseClient(
          responseBody: {
            "sessionState": "abcdefghij",
            "methodResponses": [
              [
                getPublicAssetMethod.methodName.value,
                {
                  "accountId": accountId.id.value,
                  "state": 'some-state',
                  "list": [publicAsset.toJson()],
                  "notFound": [],
                },
                methodCallId.value,
              ],
            ],
          },
          expectedBody: {
            "using":
                getPublicAssetMethod.requiredCapabilities
                    .map((capability) => capability.value.toString())
                    .toList()
                  ..sort(),
            "methodCalls": [
              [
                getPublicAssetMethod.methodName.value,
                {
                  "accountId": accountId.id.value,
                  "ids": [publicAsset.id?.value],
                },
                methodCallId.value,
              ],
            ],
          },
        );

        final requestBuilder = RequestBuilder();
        final invocation = requestBuilder.addInvocation(
          getPublicAssetMethod,
          methodCallId: methodCallId,
        );

        // act
        final response = (await requestBuilder.build().execute(
          httpMockClient,
          HttpMockResponseClient.defaultUri,
        ));
        final invocationResponse = invocation.parse(response);

        // assert
        expect(invocationResponse.list, equals([publicAsset]));
      },
    );

    test(
      'should return public asset id in notFound '
      'when call method PublicAsset/get with non-exist public asset id',
      () async {
        // arrange
        final getPublicAssetMethod = GetPublicAssetMethod(accountId)
          ..addIds({publicAsset.id!});
        final httpMockClient = HttpMockResponseClient(
          responseBody: {
            "sessionState": "abcdefghij",
            "methodResponses": [
              [
                getPublicAssetMethod.methodName.value,
                {
                  "accountId": accountId.id.value,
                  "state": 'some-state',
                  "list": [],
                  "notFound": [publicAsset.id?.value],
                },
                methodCallId.value,
              ],
            ],
          },
          expectedBody: {
            "using":
                getPublicAssetMethod.requiredCapabilities
                    .map((capability) => capability.value.toString())
                    .toList()
                  ..sort(),
            "methodCalls": [
              [
                getPublicAssetMethod.methodName.value,
                {
                  "accountId": accountId.id.value,
                  "ids": [publicAsset.id?.value],
                },
                methodCallId.value,
              ],
            ],
          },
        );

        final requestBuilder = RequestBuilder();
        final invocation = requestBuilder.addInvocation(
          getPublicAssetMethod,
          methodCallId: methodCallId,
        );

        // act
        final requestResponse = await requestBuilder.build().execute(
          httpMockClient,
          HttpMockResponseClient.defaultUri,
        );

        final response = invocation.parse(requestResponse);

        // assert
        expect(response.notFound, equals([publicAsset.id]));
      },
    );
  });
}
