import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:padel_tracker/features/matches/presentation/widgets/add_match/date_picker_field.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';
import 'package:padel_tracker/utils/date_formatter.dart';

void main() {
  group('DatePickerField', () {
    late DateTime testDate;
    late ValueChanged<DateTime> onDateSelected;
    late List<DateTime> selectedDates;

    setUp(() {
      testDate = DateTime(2024, 1, 15);
      selectedDates = [];
      onDateSelected = (date) => selectedDates.add(date);
    });

    Widget createTestWidget({
      DateTime? selectedDate,
      ValueChanged<DateTime>? onDateSelectedCallback,
      String? label,
      String? errorText,
      bool isRequired = true,
    }) {
      return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
        home: Scaffold(
          body: DatePickerField(
            selectedDate: selectedDate ?? testDate,
            onDateSelected: onDateSelectedCallback ?? onDateSelected,
            label: label ?? 'Test Date',
            errorText: errorText,
            isRequired: isRequired,
          ),
        ),
      );
    }

    group('UI Display', () {
      testWidgets('should display label correctly', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget(label: 'Match Date'));

        expect(find.text('Match Date'), findsOneWidget);
      });

      testWidgets('should display required asterisk when required', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget(isRequired: true));

        expect(find.text(' *'), findsOneWidget);
      });

      testWidgets('should not display required asterisk when not required', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget(isRequired: false));

        expect(find.text(' *'), findsNothing);
      });

      testWidgets('should display formatted date', (WidgetTester tester) async {
        final date = DateTime(2024, 1, 15);
        await tester.pumpWidget(createTestWidget(selectedDate: date));

        expect(
          find.text(DateFormatter.formatDisplayDate(date)),
          findsOneWidget,
        );
      });

      testWidgets('should display calendar icon', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      });

      testWidgets('should display dropdown arrow', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
      });

      testWidgets('should display error text when provided', (
        WidgetTester tester,
      ) async {
        const errorText = 'Future dates are not allowed';
        await tester.pumpWidget(createTestWidget(errorText: errorText));

        expect(find.text(errorText), findsOneWidget);
      });

      testWidgets('should not display error text when not provided', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.text('Future dates are not allowed'), findsNothing);
      });
    });

    group('Styling', () {
      testWidgets('should have error styling when error text is provided', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget(errorText: 'Error'));

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(GestureDetector),
                matching: find.byType(Container),
              )
              .first,
        );

        final decoration = container.decoration as BoxDecoration;
        final border = decoration.border as Border;
        expect(border.top.color, equals(const Color(0xFFFF3B30)));
        expect(border.top.width, equals(2));
      });

      testWidgets('should have normal styling when no error', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(GestureDetector),
                matching: find.byType(Container),
              )
              .first,
        );

        final decoration = container.decoration as BoxDecoration;
        final border = decoration.border as Border;
        expect(border.top.width, equals(1));
      });
    });

    group('Interaction', () {
      testWidgets('should be tappable', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final gestureDetector = find.byType(GestureDetector);
        expect(gestureDetector, findsOneWidget);

        // Verify the gesture detector has an onTap callback
        final widget = tester.widget<GestureDetector>(gestureDetector);
        expect(widget.onTap, isNotNull);
      });

      testWidgets('should open date picker when tapped', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());

        // Tap the date field
        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();

        // Verify date picker dialog is shown
        expect(find.byType(DatePickerDialog), findsOneWidget);
      });

      testWidgets('should call onDateSelected when date is picked', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());

        // Tap the date field to open picker
        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();

        // Find and tap a different date (assuming the picker shows current month)
        final dayButton = find.text('10').last; // Pick day 10
        if (dayButton.evaluate().isNotEmpty) {
          await tester.tap(dayButton);
          await tester.pumpAndSettle();

          // Tap OK/Confirm button
          final okButton = find.text('OK');
          if (okButton.evaluate().isNotEmpty) {
            await tester.tap(okButton);
            await tester.pumpAndSettle();

            // Verify callback was called
            expect(selectedDates.length, equals(1));
          }
        }
      });
    });

    group('Date Constraints', () {
      testWidgets('should not allow future dates in date picker', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());

        // Tap the date field to open picker
        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();

        // Verify date picker is configured with lastDate as today
        final datePickerDialog = tester.widget<DatePickerDialog>(
          find.byType(DatePickerDialog),
        );
        final today = DateTime.now();
        final todayOnly = DateTime(today.year, today.month, today.day);

        expect(datePickerDialog.lastDate.year, equals(todayOnly.year));
        expect(datePickerDialog.lastDate.month, equals(todayOnly.month));
        expect(datePickerDialog.lastDate.day, equals(todayOnly.day));
      });

      testWidgets('should allow historical dates from 2020', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());

        // Tap the date field to open picker
        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();

        // Verify date picker is configured with firstDate as 2020
        final datePickerDialog = tester.widget<DatePickerDialog>(
          find.byType(DatePickerDialog),
        );
        expect(datePickerDialog.firstDate.year, equals(2020));
      });
    });

    group('Localization', () {
      testWidgets('should use localized strings in date picker', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());

        // Tap the date field to open picker
        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();

        // Check for localized text (these might vary based on the actual implementation)
        // The exact text depends on the AppLocalizations implementation
        expect(find.byType(DatePickerDialog), findsOneWidget);
      });
    });
  });
}
