import 'package:flutter_test/flutter_test.dart';
import 'package:padel_tracker/utils/date_formatter.dart';

void main() {
  group('DateFormatter', () {
    group('formatDisplayDate', () {
      test('should format date in dd/MM/yyyy format', () {
        final date = DateTime(2024, 1, 15);
        expect(DateFormatter.formatDisplayDate(date), equals('15/01/2024'));
      });

      test('should handle single digit day and month', () {
        final date = DateTime(2024, 3, 5);
        expect(DateFormatter.formatDisplayDate(date), equals('05/03/2024'));
      });

      test('should handle end of year date', () {
        final date = DateTime(2023, 12, 31);
        expect(DateFormatter.formatDisplayDate(date), equals('31/12/2023'));
      });
    });

    group('formatDisplayDateWithDay', () {
      test('should format date with day name', () {
        final date = DateTime(2024, 1, 15); // Monday
        final result = DateFormatter.formatDisplayDateWithDay(date);
        expect(result, contains('15/01/2024'));
        expect(result, contains('Mon'));
      });
    });

    group('formatDisplayDateTime', () {
      test('should format date and time', () {
        final dateTime = DateTime(2024, 1, 15, 14, 30);
        expect(
          DateFormatter.formatDisplayDateTime(dateTime),
          equals('15/01/2024 14:30'),
        );
      });

      test('should handle single digit hours and minutes', () {
        final dateTime = DateTime(2024, 1, 15, 9, 5);
        expect(
          DateFormatter.formatDisplayDateTime(dateTime),
          equals('15/01/2024 09:05'),
        );
      });
    });

    group('isToday', () {
      test('should return true for today\'s date', () {
        final today = DateTime.now();
        expect(DateFormatter.isToday(today), isTrue);
      });

      test('should return true for today with different time', () {
        final now = DateTime.now();
        final todayDifferentTime = DateTime(
          now.year,
          now.month,
          now.day,
          23,
          59,
        );
        expect(DateFormatter.isToday(todayDifferentTime), isTrue);
      });

      test('should return false for yesterday', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        expect(DateFormatter.isToday(yesterday), isFalse);
      });

      test('should return false for tomorrow', () {
        final tomorrow = DateTime.now().add(const Duration(days: 1));
        expect(DateFormatter.isToday(tomorrow), isFalse);
      });
    });

    group('isFutureDate', () {
      test('should return false for today', () {
        final today = DateTime.now();
        expect(DateFormatter.isFutureDate(today), isFalse);
      });

      test('should return false for past dates', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        expect(DateFormatter.isFutureDate(yesterday), isFalse);
      });

      test('should return true for future dates', () {
        final tomorrow = DateTime.now().add(const Duration(days: 1));
        expect(DateFormatter.isFutureDate(tomorrow), isTrue);
      });

      test('should return false for today with different time', () {
        final now = DateTime.now();
        final todayLater = DateTime(now.year, now.month, now.day, 23, 59);
        expect(DateFormatter.isFutureDate(todayLater), isFalse);
      });

      test('should handle edge case of exactly midnight tomorrow', () {
        final now = DateTime.now();
        final midnightTomorrow = DateTime(
          now.year,
          now.month,
          now.day + 1,
          0,
          0,
        );
        expect(DateFormatter.isFutureDate(midnightTomorrow), isTrue);
      });
    });

    group('dateOnly', () {
      test('should return date without time component', () {
        final dateTime = DateTime(2024, 1, 15, 14, 30, 45);
        final result = DateFormatter.dateOnly(dateTime);

        expect(result.year, equals(2024));
        expect(result.month, equals(1));
        expect(result.day, equals(15));
        expect(result.hour, equals(0));
        expect(result.minute, equals(0));
        expect(result.second, equals(0));
        expect(result.millisecond, equals(0));
      });

      test('should handle midnight time', () {
        final dateTime = DateTime(2024, 1, 15, 0, 0, 0);
        final result = DateFormatter.dateOnly(dateTime);

        expect(result, equals(DateTime(2024, 1, 15)));
      });

      test('should handle end of day time', () {
        final dateTime = DateTime(2024, 1, 15, 23, 59, 59);
        final result = DateFormatter.dateOnly(dateTime);

        expect(result, equals(DateTime(2024, 1, 15)));
      });
    });
  });
}
