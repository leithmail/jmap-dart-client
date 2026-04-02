import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:custom_lints/rules/require_json_serializable_from_json.dart';
import 'package:custom_lints/rules/require_json_serializable_to_json.dart';

final plugin = CustomLints();

class CustomLints extends Plugin {
  @override
  String get name => 'custom_lints';

  @override
  void register(PluginRegistry registry) {
    registry.registerWarningRule(RequireJsonSerializableToJson());
    registry.registerWarningRule(RequireJsonSerializableFromJson());
  }
}
