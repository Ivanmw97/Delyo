import 'package:intl/intl.dart';

/// Utility class for consistent date formatting across the app
class DateFormatter {
  /// Private constructor to prevent instantiation
  DateFormatter._();

  /// Format date for display in UI (dd/MM/yyyy)
  static String formatDisplayDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Format date for display with day name (e.g., "Mon, 15/01/2024")
  static String formatDisplayDateWithDay(DateTime date) {
    return DateFormat('EEE, dd/MM/yyyy').format(date);
  }

  /// Format date and time for display (dd/MM/yyyy HH:mm)
  static String formatDisplayDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  /// Check if a date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if a date is in the future (after today)
  static bool isFutureDate(DateTime date) {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    return dateOnly.isAfter(todayOnly);
  }

  /// Get date without time component
  static DateTime dateOnly(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }
}
