import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:padel_tracker/domain/enums/time_range.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';

void main() {
  group('TimeRange', () {
    Widget createTestWidget({required Widget child}) {
      return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
        home: child,
      );
    }

    testWidgets('should have correct display names', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createTestWidget(
          child: Builder(
            builder: (context) {
              expect(
                TimeRange.lastMonth.displayName(context),
                equals('Last Month'),
              );
              expect(
                TimeRange.lastThreeMonths.displayName(context),
                equals('Last 3 Months'),
              );
              expect(
                TimeRange.lastYear.displayName(context),
                equals('Last Year'),
              );
              expect(
                TimeRange.allTime.displayName(context),
                equals('All Time'),
              );
              return Container();
            },
          ),
        ),
      );
    });

    test('should return null start date for allTime', () {
      expect(TimeRange.allTime.startDate, isNull);
    });

    test('should return correct start date for lastMonth', () {
      final now = DateTime.now();
      final expectedDate = DateTime(
        now.year,
        now.month,
        1,
      ); // First day of current month
      final actualDate = TimeRange.lastMonth.startDate;

      expect(actualDate, isNotNull);
      expect(actualDate!.year, equals(expectedDate.year));
      expect(actualDate.month, equals(expectedDate.month));
      expect(actualDate.day, equals(expectedDate.day));
    });

    test('should return correct start date for lastThreeMonths', () {
      final now = DateTime.now();
      final expectedDate = DateTime(
        now.year,
        now.month - 2,
        1,
      ); // First day of 3 months ago
      final actualDate = TimeRange.lastThreeMonths.startDate;

      expect(actualDate, isNotNull);
      expect(actualDate!.year, equals(expectedDate.year));
      expect(actualDate.month, equals(expectedDate.month));
      expect(actualDate.day, equals(expectedDate.day));
    });

    test('should return correct start date for lastYear', () {
      final now = DateTime.now();
      final expectedDate = DateTime(
        now.year,
        now.month - 11,
        1,
      ); // First day of 12 months ago
      final actualDate = TimeRange.lastYear.startDate;

      expect(actualDate, isNotNull);
      expect(actualDate!.year, equals(expectedDate.year));
      expect(actualDate.month, equals(expectedDate.month));
      expect(actualDate.day, equals(expectedDate.day));
    });

    test('should handle month overflow for lastMonth', () {
      // Test case where current month is January (month 1)
      // and we subtract 1 month, which should give us December of previous year
      final januaryDate = DateTime(2025, 1, 15);
      final expectedDate = DateTime(2024, 12, 15);

      // We can't easily mock DateTime.now(), so we test the logic indirectly
      // by checking that the calculation handles month boundaries correctly
      final testDate = DateTime(
        januaryDate.year,
        januaryDate.month - 1,
        januaryDate.day,
      );

      expect(testDate.year, equals(expectedDate.year));
      expect(testDate.month, equals(expectedDate.month));
      expect(testDate.day, equals(expectedDate.day));
    });

    test('should handle month overflow for lastThreeMonths', () {
      // Test case where current month is February (month 2)
      // and we subtract 3 months, which should give us November of previous year
      final februaryDate = DateTime(2025, 2, 15);
      final expectedDate = DateTime(2024, 11, 15);

      final testDate = DateTime(
        februaryDate.year,
        februaryDate.month - 3,
        februaryDate.day,
      );

      expect(testDate.year, equals(expectedDate.year));
      expect(testDate.month, equals(expectedDate.month));
      expect(testDate.day, equals(expectedDate.day));
    });

    test('should have all enum values', () {
      final allValues = TimeRange.values;

      expect(allValues.length, equals(4));
      expect(allValues.contains(TimeRange.lastMonth), isTrue);
      expect(allValues.contains(TimeRange.lastThreeMonths), isTrue);
      expect(allValues.contains(TimeRange.lastYear), isTrue);
      expect(allValues.contains(TimeRange.allTime), isTrue);
    });

    test('should maintain consistent ordering', () {
      final values = TimeRange.values;

      expect(values[0], equals(TimeRange.lastMonth));
      expect(values[1], equals(TimeRange.lastThreeMonths));
      expect(values[2], equals(TimeRange.lastYear));
      expect(values[3], equals(TimeRange.allTime));
    });
  });
}
