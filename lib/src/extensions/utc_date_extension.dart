import 'package:jmap_dart_client/entities/core/utc_date.dart';
import 'package:jmap_dart_client/src/extensions/date_time_extension.dart';

extension UTCDateExtension on UTCDate? {
  int compareToSort(UTCDate? utcDate, bool? isAscending) {
    if (this != null && utcDate != null) {
      return this!.value.compareToSort(utcDate.value, isAscending ?? false);
    }
    return 0;
  }
}
