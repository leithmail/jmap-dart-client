import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';

class RequireJsonSerializableFromJson extends AnalysisRule {
  static const LintCode code = LintCode('require_json_serializable_from_json',
      '@JsonSerializable classes must declare `factory ClassName.fromJson(Map<String, dynamic> json)`.',
      severity: DiagnosticSeverity.WARNING);

  RequireJsonSerializableFromJson()
      : super(
          name: 'require_json_serializable_from_json',
          description:
              '@JsonSerializable classes must declare `factory ClassName.fromJson(Map<String, dynamic> json)`.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
      RuleVisitorRegistry registry, RuleContext context) {
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

    final hasValidFromJson = element.constructors.any(_isValidFromJson);

    if (!hasValidFromJson) {
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
    final hasCreateFactoryFalse = args.any((arg) =>
        arg is NamedExpression &&
        arg.name.label.name == 'createFactory' &&
        arg.expression is BooleanLiteral &&
        (arg.expression as BooleanLiteral).value == false);
    return !hasCreateFactoryFalse;
  }

  bool _isValidFromJson(ConstructorElement constructor) {
    if (!constructor.isFactory || constructor.name != 'fromJson') {
      return false;
    }

    final parameters = constructor.formalParameters;
    if (parameters.length != 1) return false;

    final parameter = parameters.single;
    final type = _normalizeTypeSource(parameter.type.getDisplayString());

    return type == 'Map<String,dynamic>' && parameter.name == 'json';
  }

  static String _normalizeTypeSource(String? source) {
    return source?.replaceAll(RegExp(r'\s+'), '') ?? '';
  }
}
