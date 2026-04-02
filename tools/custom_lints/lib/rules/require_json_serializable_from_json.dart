import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show DiagnosticSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class RequireJsonSerializableFromJson extends DartLintRule {
  RequireJsonSerializableFromJson()
    : super(
        code: const LintCode(
          errorSeverity: DiagnosticSeverity.WARNING,
          name: 'require_json_serializable_from_json',
          problemMessage:
              '@JsonSerializable classes must declare `factory ClassName.fromJson(Map<String, dynamic> json)`.',
        ),
      );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((ClassDeclaration node) {
      if (!_hasJsonSerializableAnnotation(node)) return;

      final hasValidFromJson = node.members
          .whereType<ConstructorDeclaration>()
          .any(_isValidFromJson);

      if (!hasValidFromJson) {
        reporter.atNode(node, code);
      }
    });
  }

  bool _isValidFromJson(ConstructorDeclaration constructor) {
    if (constructor.factoryKeyword == null ||
        constructor.name?.lexeme != 'fromJson') {
      return false;
    }

    final parameters = constructor.parameters.parameters;
    if (parameters.length != 1) return false;

    final parameter = parameters.single;
    if (parameter is! SimpleFormalParameter) return false;

    final type = _normalizeTypeSource(parameter.type?.toSource());
    final name = parameter.name?.lexeme;

    return type == 'Map<String,dynamic>' && name == 'json';
  }

  static bool _hasJsonSerializableAnnotation(ClassDeclaration node) {
    return node.metadata.any(
      (annotation) => annotation.name.name == 'JsonSerializable',
    );
  }

  static String _normalizeTypeSource(String? source) {
    return source?.replaceAll(RegExp(r'\s+'), '') ?? '';
  }
}
