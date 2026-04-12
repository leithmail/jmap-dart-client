extension type ReferencePath._(String _value) {
  static final root = ReferencePath._('');

  ReferencePath append(String segment) => ReferencePath._('$_value/$segment');

  ReferencePath get each => append('*');

  String toPointer() => _value;
}
