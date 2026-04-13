import 'package:jmap_dart_client/api/method/argument/property.dart';

class QuotaProperty extends Property {
  static const id = QuotaProperty('id');
  static const resourceType = QuotaProperty('resourceType');
  static const used = QuotaProperty('used');
  static const scope = QuotaProperty('scope');
  static const name = QuotaProperty('name');
  static const dataTypes = QuotaProperty('dataTypes');
  static const hardLimit = QuotaProperty('hardLimit');
  static const limit = QuotaProperty('limit');
  static const warnLimit = QuotaProperty('warnLimit');
  static const softLimit = QuotaProperty('softLimit');
  static const description = QuotaProperty('description');
  static const types = QuotaProperty('types');
  const QuotaProperty(super.value);
}
