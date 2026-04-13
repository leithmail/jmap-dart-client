class Id {
  final String _value;

  const Id(String value) : _value = value;
  String get value => _value;
  String toJson() => _value;
  String toString() => _value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Id && runtimeType == other.runtimeType && _value == other._value;

  @override
  int get hashCode => _value.hashCode;
}
