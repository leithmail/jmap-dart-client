import 'package:jmap_dart_client/entities/core/unsigned_int.dart';
import 'package:jmap_dart_client/src/extensions/num_extension.dart';

extension UnsignedIntExtension on UnsignedInt? {
  int compareToSort(UnsignedInt? unsignedInt, bool? isAscending) {
    if (this != null && unsignedInt != null) {
      return this!.value.compareToSort(unsignedInt.value, isAscending);
    }
    return 0;
  }
}
