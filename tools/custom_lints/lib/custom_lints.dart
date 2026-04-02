import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'rules/require_json_serializable_from_json.dart';
import 'rules/require_json_serializable_to_json.dart';

PluginBase createPlugin() => _ExampleLinter();

class _ExampleLinter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        RequireJsonSerializableToJson(),
        RequireJsonSerializableFromJson(),
      ];
}
