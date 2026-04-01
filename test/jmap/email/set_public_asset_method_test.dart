import 'package:jmap_dart_client/api/request/patch_object.dart';
import 'package:jmap_dart_client/api/request/request_invocation.dart';
import 'package:jmap_dart_client/api/request_builder.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/email/public_asset.dart';
import 'package:jmap_dart_client/entities/identity/identity.dart';
import 'package:jmap_dart_client/errors/set_error.dart';
import 'package:jmap_dart_client/methods/email/set_public_asset_method.dart';
import 'package:jmap_dart_client/src/converters/identities/public_asset_identities_converter.dart';
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

  group('set public asset method test:', () {
    test('should return created public asset '
        'when PublicAsset/set create return success', () async {
      // arrange
      final createId = Id('def456');
      final createObject = PublicAsset(
        blobId: publicAsset.blobId,
        identityIds: publicAsset.identityIds,
      );
      final method = SetPublicAssetMethod(accountId)
        ..addCreate(createId, createObject);
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "abcdefghij",
          "methodResponses": [
            [
              method.methodName.value,
              {
                "accountId": accountId.id.value,
                "newState": 'some-state',
                "created": {createId.value: publicAsset.toJson()},
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
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
                "create": {createId.value: createObject.toJson()},
              },
              methodCallId.value,
            ],
          ],
        },
      );

      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        method,
        methodCallId: methodCallId,
      );

      // act
      final requestResponse = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );
      final response = invocation.parse(requestResponse);

      // assert
      expect(response.created, equals({createId: publicAsset}));
    });

    test('should return notCreated '
        'when PublicAsset/set create return failure', () async {
      // arrange
      const errorDescription = 'Missing \'/blobId\' property';
      final createId = Id('def456');
      final createObject = PublicAsset(
        blobId: null,
        identityIds: publicAsset.identityIds,
      );
      final method = SetPublicAssetMethod(accountId)
        ..addCreate(createId, createObject);
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "abcdefghij",
          "methodResponses": [
            [
              method.methodName.value,
              {
                "accountId": accountId.id.value,
                "oldState": 'some-old-state',
                "newState": 'some-state',
                "notCreated": {
                  createId.value: {
                    "type": "invalidArguments",
                    "description": errorDescription,
                  },
                },
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
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
                "create": {createId.value: createObject.toJson()},
              },
              methodCallId.value,
            ],
          ],
        },
      );

      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        method,
        methodCallId: methodCallId,
      );

      // act
      final requestResponse = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );
      final response = invocation.parse(requestResponse);

      // assert
      expect(
        response.notCreated?[createId],
        SetError(SetError.invalidArguments, description: errorDescription),
      );
    });

    test('should return destroyed public asset ids '
        'when PublicAsset/set destroy return success', () async {
      // arrange
      final method = SetPublicAssetMethod(accountId)
        ..addDestroy({publicAsset.id!});
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "abcdefghij",
          "methodResponses": [
            [
              method.methodName.value,
              {
                "accountId": accountId.id.value,
                "newState": 'some-state',
                "destroyed": [publicAsset.id?.value],
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
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
                "destroy": [publicAsset.id?.value],
              },
              methodCallId.value,
            ],
          ],
        },
      );

      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        method,
        methodCallId: methodCallId,
      );

      // act
      final requestResponse = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );
      final response = invocation.parse(requestResponse);

      // assert
      expect(response.destroyed, equals({publicAsset.id}));
    });

    test('should return notDestroyed '
        'when PublicAsset/set destroy return failure', () async {
      // arrange
      String errorDescription(String? id) => 'Invalid UUID string: $id';
      final method = SetPublicAssetMethod(accountId)
        ..addDestroy({publicAsset.id!});
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "abcdefghij",
          "methodResponses": [
            [
              method.methodName.value,
              {
                "accountId": accountId.id.value,
                "oldState": 'some-old-state',
                "newState": 'some-state',
                "notDestroyed": {
                  publicAsset.id?.value: {
                    "type": "invalidArguments",
                    "description": errorDescription(publicAsset.id?.value),
                  },
                },
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
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
                "destroy": [publicAsset.id?.value],
              },
              methodCallId.value,
            ],
          ],
        },
      );

      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        method,
        methodCallId: methodCallId,
      );

      // act
      final requestResponse = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );
      final response = invocation.parse(requestResponse);

      // assert
      expect(
        response.notDestroyed?[publicAsset.id],
        SetError(
          SetError.invalidArguments,
          description: errorDescription(publicAsset.id?.value),
        ),
      );
    });

    test('should return updated public asset ids '
        'when PublicAsset/set update return success', () async {
      // arrange
      final updateObject = PatchObject({
        PatchObject.identityIdsProperty: const PublicAssetIdentitiesConverter()
            .toJson(publicAsset.identityIds!),
      });
      final method = SetPublicAssetMethod(accountId)
        ..addUpdates({publicAsset.id!: updateObject});
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "abcdefghij",
          "methodResponses": [
            [
              method.methodName.value,
              {
                "accountId": accountId.id.value,
                "newState": 'some-state',
                "updated": {publicAsset.id?.value: null},
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
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
                "update": {publicAsset.id?.value: updateObject.toJson()},
              },
              methodCallId.value,
            ],
          ],
        },
      );

      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        method,
        methodCallId: methodCallId,
      );

      // act
      final requestResponse = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );
      final response = invocation.parse(requestResponse);

      // assert
      expect(response.updated, equals({publicAsset.id: null}));
    });

    test('should return notUpdated '
        'when PublicAsset/set update return failure', () async {
      // arrange
      const errorDescription = 'Invalid identity';
      final updateObject = PatchObject({
        PatchObject.identityIdsProperty: const PublicAssetIdentitiesConverter()
            .toJson(publicAsset.identityIds!),
      });
      final method = SetPublicAssetMethod(accountId)
        ..addUpdates({publicAsset.id!: updateObject});
      final httpMockClient = HttpMockResponseClient(
        responseBody: {
          "sessionState": "abcdefghij",
          "methodResponses": [
            [
              method.methodName.value,
              {
                "accountId": accountId.id.value,
                "oldState": 'some-old-state',
                "newState": 'some-state',
                "notUpdated": {
                  publicAsset.id?.value: {
                    "type": "invalidArguments",
                    "description": errorDescription,
                  },
                },
              },
              methodCallId.value,
            ],
          ],
        },
        expectedBody: {
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
                "update": {publicAsset.id?.value: updateObject.toJson()},
              },
              methodCallId.value,
            ],
          ],
        },
      );

      final requestBuilder = RequestBuilder();
      final invocation = requestBuilder.addInvocation(
        method,
        methodCallId: methodCallId,
      );

      // act
      final requestResponse = await requestBuilder.build().execute(
        httpMockClient,
        HttpMockResponseClient.defaultUri,
      );
      final response = invocation.parse(requestResponse);

      // assert
      expect(
        response.notUpdated?[publicAsset.id],
        SetError(SetError.invalidArguments, description: errorDescription),
      );
    });
  });
}
