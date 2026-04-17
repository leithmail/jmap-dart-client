import 'package:jmap_dart_client/entities/core/utc_date.dart';
import 'package:test/test.dart';

void main() {
  const utcDateStringTest = '2021-10-04T04:39:56.000Z';
  final expectUTCDate = UTCDate(
    DateTime.parse('2021-10-04T04:39:56.000Z').toUtc(),
  );
  final testUTCDate = UTCDate(
    DateTime.parse('2021-10-04T04:39:56.000Z').toUtc(),
  );
  const expectUTCDateString = '2021-10-04T04:39:56.000Z';

  group('UTCDateConverter', () {
    test('should return UTCDate when receive a properly formatted json', () {
      expect(expectUTCDate, UTCDate.fromJson(utcDateStringTest));
    });

    test('should return utc date string valid when receive a utc date', () {
      expect(expectUTCDateString, testUTCDate.toJson());
    });
  });

  group('UTCDateNullableConverter', () {
    test('should return UTCDate when receive a properly formatted json', () {
      expect(expectUTCDate, UTCDate.fromJson(utcDateStringTest));
    });

    test('should return utc date string valid when receive a utc date', () {
      expect(expectUTCDateString, testUTCDate.toJson());
    });
  });
}
