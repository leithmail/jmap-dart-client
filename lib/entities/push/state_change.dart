import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/entities/core/account_id.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/entities/push/type_state.dart';

class StateChange with EquatableMixin {
  final String type;
  final Map<AccountId, TypeState> changed;

  StateChange(this.type, this.changed);

  factory StateChange.fromJson(
    Map<String, dynamic> json, {
    Map<AccountId, TypeState Function(Map<String, dynamic>)>?
    customTypeStateConverters,
  }) {
    final converter = _TypeStateConverter(customTypeStateConverters);
    return StateChange(
      json['@type'] as String,
      (json['changed'] as Map<String, dynamic>).map(
        (key, value) => converter.convert(key, value),
      ),
    );
  }

  @override
  List<Object?> get props => [type, changed];
}

class _TypeStateConverter {
  final Map<AccountId, TypeState Function(Map<String, dynamic>)> _converters =
      {};

  _TypeStateConverter([
    Map<AccountId, TypeState Function(Map<String, dynamic>)>? customConverters,
  ]) {
    if (customConverters != null) {
      _converters.addAll(customConverters);
    }
  }

  MapEntry<AccountId, TypeState> convert(String key, dynamic value) {
    final identifier = AccountId(Id(key));
    final converter = _converters[identifier];
    if (converter != null) {
      return MapEntry(identifier, converter.call(value));
    } else {
      return MapEntry(identifier, TypeState(value));
    }
  }
}
