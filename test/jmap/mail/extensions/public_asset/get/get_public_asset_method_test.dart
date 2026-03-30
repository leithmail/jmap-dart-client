import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/extensions/public_asset/get/get_public_asset_method.dart';
import 'package:jmap_dart_client/jmap/mail/extensions/public_asset/get/get_public_asset_response.dart';
import 'package:jmap_dart_client/jmap/mail/extensions/public_asset/public_asset.dart';
import 'package:test/test.dart';

import '../../../../../http_mocks.dart';

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
            "using": getPublicAssetMethod.requiredCapabilities
                .map((capability) => capability.value.toString())
                .toList(),
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
        final httpClient = MockEndpointHttpClient(httpMockClient);
        final processingInvocation = ProcessingInvocation();
        final requestBuilder = JmapRequestBuilder(
          httpClient,
          processingInvocation,
        );
        final invocation = requestBuilder.invocation(
          getPublicAssetMethod,
          methodCallId: methodCallId,
        );

        // act
        final response =
            (await (requestBuilder
                      ..usings(getPublicAssetMethod.requiredCapabilities))
                    .build()
                    .execute())
                .parse<GetPublicAssetResponse>(
                  invocation.methodCallId,
                  GetPublicAssetResponse.deserialize,
                );

        // assert
        expect((response)?.list, equals([publicAsset]));
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
            "using": getPublicAssetMethod.requiredCapabilities
                .map((capability) => capability.value.toString())
                .toList(),
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
        final httpClient = MockEndpointHttpClient(httpMockClient);
        final processingInvocation = ProcessingInvocation();
        final requestBuilder = JmapRequestBuilder(
          httpClient,
          processingInvocation,
        );
        final invocation = requestBuilder.invocation(
          getPublicAssetMethod,
          methodCallId: methodCallId,
        );

        // act
        final response =
            (await (requestBuilder
                      ..usings(getPublicAssetMethod.requiredCapabilities))
                    .build()
                    .execute())
                .parse<GetPublicAssetResponse>(
                  invocation.methodCallId,
                  GetPublicAssetResponse.deserialize,
                );

        // assert
        expect((response)?.notFound, equals([publicAsset.id]));
      },
    );
  });
}
