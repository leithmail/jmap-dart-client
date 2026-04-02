import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show DiagnosticSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class RequireJsonSerializableToJson extends DartLintRule {
  RequireJsonSerializableToJson()
      : super(
          code: const LintCode(
            errorSeverity: DiagnosticSeverity.WARNING,
            name: 'require_json_serializable_to_json',
            problemMessage:
                '@JsonSerializable classes must declare `Map<String, dynamic> toJson()`.',
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

      final hasValidToJson = node.members.whereType<MethodDeclaration>().any(
            _isValidToJson,
          );

      if (!hasValidToJson) {
        reporter.atNode(node, code);
      }
    });
  }

  bool _isValidToJson(MethodDeclaration method) {
    if (method.name.lexeme != 'toJson' ||
        method.isStatic ||
        method.isGetter ||
        method.isSetter) {
      return false;
    }

    final parameters =
        method.parameters?.parameters ?? const <FormalParameter>[];
    final returnType = method.returnType?.toSource();

    return parameters.isEmpty &&
        _normalizeTypeSource(returnType) == 'Map<String,dynamic>';
  }

  static bool _hasJsonSerializableAnnotation(ClassDeclaration node) {
    final matches = node.metadata.whereType<Annotation>();
    final annotation = matches.any((a) => a.name.name == 'JsonSerializable')
        ? matches.firstWhere((a) => a.name.name == 'JsonSerializable')
        : null;
    if (annotation == null) {
      return false;
    }

    final args = annotation.arguments?.arguments ?? const <Expression>[];
    final hasCreateToJsonFalse = args.any((arg) =>
        arg is NamedExpression &&
        arg.name.label.name == 'createToJson' &&
        arg.expression is BooleanLiteral &&
        (arg.expression as BooleanLiteral).value == false);
    return !hasCreateToJsonFalse;
  }

  static String _normalizeTypeSource(String? source) {
    return source?.replaceAll(RegExp(r'\s+'), '') ?? '';
  }
}
