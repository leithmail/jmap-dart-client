import 'package:jmap_dart_client/api/api.dart';
import 'package:test/test.dart';

class _TestMethodResponse extends MethodResponse {}

class _ExampleReference extends ResultReferenceTree {
  late final ResultReference first;
  late final ResultReference another;
  late final ResultReferenceArray<ResultReference> ids;

  _ExampleReference(super.resultReference) {
    first = $('first');
    another = $('another');
    ids = ResultReferenceArray($('ids'), (ref) => ref);
  }
}

class _TestResultReferenceTree extends ResultReferenceTree {
  late final _ExampleReference example;
  late final ResultReferenceArray<_ExampleReference> list;
  late final ResultReferenceArray<ResultReference> simpleList;

  _TestResultReferenceTree(super.resultReference) {
    example = _ExampleReference($('example'));
    list = ResultReferenceArray($('list'), _ExampleReference.new);
    simpleList = ResultReferenceArray($('simpleList'), (ref) => ref);
  }
}

class _TestMethod
    extends Method<_TestMethodResponse, _TestResultReferenceTree> {
  @override
  MethodName methodName() => MethodName('test');

  @override
  Set<Never> requiredCapabilities() => <Never>{};

  @override
  _TestMethodResponse responseFromJson(Map<String, dynamic> json) {
    return _TestMethodResponse();
  }

  @override
  Map<String, dynamic> toJson() => {};

  @override
  _TestResultReferenceTree resultReferenceTree(MethodCallId resultOf) {
    return _TestResultReferenceTree(
      ResultReference(
        resultOf: resultOf,
        name: methodName(),
        path: ReferencePath.root,
      ),
    );
  }
}

void _expectReference(
  ResultReference reference, {
  required String resultOf,
  required String name,
  required String path,
}) {
  expect(reference.resultOf, equals(MethodCallId(resultOf)));
  expect(reference.name, equals(MethodName(name)));
  expect(reference.path.toJson(), equals(path));
}

void main() {
  group('RequestInvocation.resultReferenceTree', () {
    test(
      'creates a root reference with the invocation call id and method name',
      () {
        final invocation = RequestBuilder().addInvocation(
          _TestMethod(),
          methodCallId: MethodCallId('firstCall'),
        );

        final tree = invocation.resultReferenceTree();

        _expectReference(
          tree.$ref,
          resultOf: 'firstCall',
          name: 'test',
          path: '',
        );
      },
    );

    test(
      'propagates metadata and builds paths for nested object references',
      () {
        final invocation = RequestBuilder().addInvocation(
          _TestMethod(),
          methodCallId: MethodCallId('nestedCall'),
        );

        final tree = invocation.resultReferenceTree();

        _expectReference(
          tree.example.$ref,
          resultOf: 'nestedCall',
          name: 'test',
          path: '/example',
        );
        _expectReference(
          tree.example.first,
          resultOf: 'nestedCall',
          name: 'test',
          path: '/example/first',
        );
        _expectReference(
          tree.example.another,
          resultOf: 'nestedCall',
          name: 'test',
          path: '/example/another',
        );
      },
    );

    test('builds correct paths for arrays and each traversal', () {
      final invocation = RequestBuilder().addInvocation(
        _TestMethod(),
        methodCallId: MethodCallId('arrayCall'),
      );

      final tree = invocation.resultReferenceTree();

      _expectReference(
        tree.list.$ref,
        resultOf: 'arrayCall',
        name: 'test',
        path: '/list',
      );
      _expectReference(
        tree.list.$each.$ref,
        resultOf: 'arrayCall',
        name: 'test',
        path: '/list/*',
      );
      _expectReference(
        tree.list.$each.ids.$ref,
        resultOf: 'arrayCall',
        name: 'test',
        path: '/list/*/ids',
      );
      _expectReference(
        tree.list.$each.ids.$each,
        resultOf: 'arrayCall',
        name: 'test',
        path: '/list/*/ids/*',
      );
    });

    test('supports simple arrays of scalar references', () {
      final invocation = RequestBuilder().addInvocation(
        _TestMethod(),
        methodCallId: MethodCallId('simpleArrayCall'),
      );

      final tree = invocation.resultReferenceTree();

      _expectReference(
        tree.simpleList.$ref,
        resultOf: 'simpleArrayCall',
        name: 'test',
        path: '/simpleList',
      );
      _expectReference(
        tree.simpleList.$each,
        resultOf: 'simpleArrayCall',
        name: 'test',
        path: '/simpleList/*',
      );
    });

    test(
      'produces JMAP-ready result reference JSON for common reuse cases',
      () {
        final invocation = RequestBuilder().addInvocation(
          _TestMethod(),
          methodCallId: MethodCallId('jsonCall'),
        );

        final tree = invocation.resultReferenceTree();

        expect(tree.example.first.toJson(), {
          'resultOf': 'jsonCall',
          'name': 'test',
          'path': '/example/first',
        });
        expect(tree.list.$each.ids.$each.toJson(), {
          'resultOf': 'jsonCall',
          'name': 'test',
          'path': '/list/*/ids/*',
        });
      },
    );

    test(
      'keeps the same tree shape across invocations while using each call id',
      () {
        final requestBuilder = RequestBuilder();
        final firstInvocation = requestBuilder.addInvocation(
          _TestMethod(),
          methodCallId: MethodCallId('first'),
        );
        final secondInvocation = requestBuilder.addInvocation(
          _TestMethod(),
          methodCallId: MethodCallId('second'),
        );

        final firstTree = firstInvocation.resultReferenceTree();
        final secondTree = secondInvocation.resultReferenceTree();

        _expectReference(
          firstTree.simpleList.$each,
          resultOf: 'first',
          name: 'test',
          path: '/simpleList/*',
        );
        _expectReference(
          secondTree.simpleList.$each,
          resultOf: 'second',
          name: 'test',
          path: '/simpleList/*',
        );
      },
    );
  });
}
