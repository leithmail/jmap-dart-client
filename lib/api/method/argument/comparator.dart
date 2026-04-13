import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/argument/property.dart';

abstract class Comparator<T extends SortProperty> {
  final T property;
  final bool isAscending;

  Comparator(this.property, {this.isAscending = true});

  Map<String, dynamic> toJson() => {
    'property': property.value,
    'isAscending': isAscending,
  };
}

abstract class SortProperty extends Property {
  const SortProperty(super.value);
}

class SortSlot<T extends Comparator> extends ArgumentSlotBase {
  final String _key;
  List<T>? _sort;

  SortSlot(this._key);

  void set(List<T> sort) => _sort = sort;

  @override
  MapEntry<String, dynamic>? toEntry() {
    if (_sort == null) return null;
    return MapEntry(_key, _sort!.map((c) => c.toJson()).toList());
  }
}
