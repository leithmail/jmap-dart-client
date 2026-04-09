extension type ReferencePath._(String _value) {
  static final root = ReferencePath._('');

  static ReferencePath idsPath = ReferencePath.root.append('ids').each;
  static ReferencePath createdPath = ReferencePath.root.append('created').each;
  static ReferencePath updatedPath = ReferencePath.root.append('updated').each;
  static ReferencePath updatedPropertiesPath = ReferencePath.root.append(
    'updatedProperties',
  );

  ReferencePath append(String segment) => ReferencePath._('$_value/$segment');

  ReferencePath get each => append('*');

  String toPointer() => _value.isEmpty ? '' : '/$_value';
  String toJson() => toPointer();
}
