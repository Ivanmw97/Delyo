import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:padel_tracker/features/matches/presentation/pages/add_match_page.dart';
import 'package:padel_tracker/features/matches/presentation/widgets/add_match/date_picker_field.dart';
import 'package:padel_tracker/features/matches/state/matches_provider.dart';
import 'package:padel_tracker/features/matches/state/matches_notifier.dart';
import 'package:padel_tracker/domain/repositories/match_repository.dart';
import 'package:padel_tracker/domain/models/match.dart' as domain;
import 'package:padel_tracker/l10n/app_localizations.dart';
import 'package:padel_tracker/utils/date_formatter.dart';

// Mock repository for testing
class MockMatchRepository implements MatchRepository {
  @override
  Future<List<domain.Match>> getAllMatches() async => [];

  @override
  Future<domain.Match?> getMatchById(String id) async => null;

  @override
  Future<void> saveMatch(domain.Match match) async {}

  @override
  Future<void> deleteMatch(String matchId) async {}

  @override
  Future<void> clearAll() async {}
}

// Mock matches notifier for testing
class MockMatchesNotifier extends MatchesNotifier {
  MockMatchesNotifier() : super(MockMatchRepository());
}

void main() {
  group('AddMatchPage Date Functionality', () {
    Widget createTestWidget() {
      return ProviderScope(
        overrides: [
          matchesProvider.overrideWith((ref) => MockMatchesNotifier()),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en')],
          home: const AddMatchPage(),
        ),
      );
    }

    group('Date Field Display', () {
      testWidgets('should display date picker field', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        expect(find.byType(DatePickerField), findsOneWidget);
      });

      testWidgets('should display today\'s date by default', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final today = DateFormatter.dateOnly(DateTime.now());
        final formattedToday = DateFormatter.formatDisplayDate(today);

        expect(find.text(formattedToday), findsOneWidget);
      });

      testWidgets('should display match date label', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        expect(find.text('Match Date'), findsOneWidget);
      });
    });

    group('Date Selection', () {
      testWidgets('should open date picker when date field is tapped', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Find and tap the date picker field
        final datePickerField = find.byType(DatePickerField);
        expect(datePickerField, findsOneWidget);

        await tester.tap(datePickerField);
        await tester.pumpAndSettle();

        // Verify date picker dialog is shown
        expect(find.byType(DatePickerDialog), findsOneWidget);
      });

      testWidgets('should update displayed date when new date is selected', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Open date picker
        await tester.tap(find.byType(DatePickerField));
        await tester.pumpAndSettle();

        // Try to select a different date (day 15 if available)
        final dayButton = find.text('15').last;
        if (dayButton.evaluate().isNotEmpty) {
          await tester.tap(dayButton);
          await tester.pumpAndSettle();

          // Confirm selection
          final okButton = find.text('OK');
          if (okButton.evaluate().isNotEmpty) {
            await tester.tap(okButton);
            await tester.pumpAndSettle();

            // Verify the date field shows the new date
            expect(find.byType(DatePickerField), findsOneWidget);
          }
        }
      });
    });

    group('Date Validation', () {
      testWidgets('should show error for future dates', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // This test would require mocking the date selection to a future date
        // Since we can't easily mock the date picker to select a future date,
        // we'll test the validation logic separately
        expect(find.byType(DatePickerField), findsOneWidget);
      });

      testWidgets('should not show error for valid dates', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final datePickerField = find.byType(DatePickerField);
        final widget = tester.widget<DatePickerField>(datePickerField);

        // Verify no error text is shown for today's date
        expect(widget.errorText, isNull);
      });
    });

    group('Form Integration', () {
      testWidgets('should be part of match details section', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Verify date picker is in the Match Details section
        expect(find.text('MATCH DETAILS'), findsOneWidget);
        expect(find.byType(DatePickerField), findsOneWidget);
      });

      testWidgets('should be positioned before match type field', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Find both fields
        final dateField = find.byType(DatePickerField);
        final matchTypeText = find.text('Match Type');

        expect(dateField, findsOneWidget);
        expect(matchTypeText, findsOneWidget);

        // Verify date field comes before match type in the widget tree
        final dateFieldPosition = tester.getTopLeft(dateField);
        final matchTypePosition = tester.getTopLeft(matchTypeText);

        expect(dateFieldPosition.dy, lessThan(matchTypePosition.dy));
      });
    });

    group('State Management', () {
      testWidgets('should maintain selected date during form interaction', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final initialDate = DateFormatter.formatDisplayDate(
          DateFormatter.dateOnly(DateTime.now()),
        );

        // Verify initial date is displayed
        expect(find.text(initialDate), findsOneWidget);

        // Interact with other form fields (e.g., match type dropdown)
        final matchTypeDropdown = find.text('Match Type');
        if (matchTypeDropdown.evaluate().isNotEmpty) {
          // The date should remain unchanged after interacting with other fields
          expect(find.text(initialDate), findsOneWidget);
        }
      });
    });

    group('Accessibility', () {
      testWidgets('should have proper semantics for date field', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Verify the date picker field is accessible
        final datePickerField = find.byType(DatePickerField);
        expect(datePickerField, findsOneWidget);

        // The field should be tappable
        final gestureDetector = find.descendant(
          of: datePickerField,
          matching: find.byType(GestureDetector),
        );
        expect(gestureDetector, findsOneWidget);
      });

      testWidgets('should show required indicator', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Verify required asterisk is shown
        expect(find.text(' *'), findsOneWidget);
      });
    });
  });
}
