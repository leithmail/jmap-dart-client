import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';

class RequireJsonSerializableToJson extends AnalysisRule {
  static const LintCode code = LintCode(
    'require_json_serializable_to_json',
    '@JsonSerializable classes must declare `Map<String, dynamic> toJson()`.',
    severity: DiagnosticSeverity.WARNING,
  );

  RequireJsonSerializableToJson()
    : super(
        name: 'require_json_serializable_to_json',
        description:
            '@JsonSerializable classes must declare `Map<String, dynamic> toJson()`.',
      );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _Visitor(this, context);
    registry.addClassDeclaration(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final AnalysisRule rule;

  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (!_hasJsonSerializableAnnotation(node)) return;
    final element = node.declaredFragment?.element;
    if (element == null) return;

    final hasValidToJson = element.methods.any(_isValidToJson);

    if (!hasValidToJson) {
      rule.reportAtNode(node);
    }
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
    final hasCreateToJsonFalse = args.any(
      (arg) =>
          arg is NamedExpression &&
          arg.name.label.name == 'createToJson' &&
          arg.expression is BooleanLiteral &&
          (arg.expression as BooleanLiteral).value == false,
    );
    return !hasCreateToJsonFalse;
  }

  bool _isValidToJson(MethodElement method) {
    return method.name == 'toJson' &&
        !method.isStatic &&
        method.formalParameters.isEmpty &&
        _normalizeTypeSource(method.returnType.getDisplayString()) ==
            'Map<String,dynamic>';
  }

  static String _normalizeTypeSource(String? source) {
    return source?.replaceAll(RegExp(r'\s+'), '') ?? '';
  }
}
