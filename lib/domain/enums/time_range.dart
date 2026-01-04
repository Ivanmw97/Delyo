import 'package:flutter/widgets.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';

/// Time range enumeration for filtering matches
/// Defines different time periods for filtering match data
enum TimeRange {
  /// Last month from current date
  lastMonth,

  /// Last 3 months from current date
  lastThreeMonths,

  /// Last year from current date
  lastYear,

  /// All time - no filtering
  allTime;

  String displayName(BuildContext context) {
    switch (this) {
      case TimeRange.lastMonth:
        return AppLocalizations.of(context)!.lastMonth;
      case TimeRange.lastThreeMonths:
        return AppLocalizations.of(context)!.lastThreeMonths;
      case TimeRange.lastYear:
        return AppLocalizations.of(context)!.lastYear;
      case TimeRange.allTime:
        return AppLocalizations.of(context)!.allTime;
    }
  }

  /// Start date for filtering matches
  /// Returns null for allTime (no filtering needed)
  DateTime? get startDate {
    final now = DateTime.now();
    switch (this) {
      case TimeRange.lastMonth:
        // Current calendar month: start from day 1 of current month
        return DateTime(now.year, now.month, 1);
      case TimeRange.lastThreeMonths:
        // Last 3 calendar months: start from day 1 of 3 months ago
        return DateTime(now.year, now.month - 2, 1);
      case TimeRange.lastYear:
        // Last 12 calendar months: start from day 1 of 12 months ago
        return DateTime(now.year, now.month - 11, 1);
      case TimeRange.allTime:
        return null; // No filtering
    }
  }

  /// End date for filtering matches
  /// Returns null for allTime (no filtering needed)
  DateTime? get endDate {
    final now = DateTime.now();
    switch (this) {
      case TimeRange.lastMonth:
        // Current calendar month: end at last moment of current month
        return DateTime(
          now.year,
          now.month + 1,
          1,
        ).subtract(const Duration(microseconds: 1));
      case TimeRange.lastThreeMonths:
        // Last 3 calendar months: end at last moment of current month
        return DateTime(
          now.year,
          now.month + 1,
          1,
        ).subtract(const Duration(microseconds: 1));
      case TimeRange.lastYear:
        // Last 12 calendar months: end at last moment of current month
        return DateTime(
          now.year,
          now.month + 1,
          1,
        ).subtract(const Duration(microseconds: 1));
      case TimeRange.allTime:
        return null; // No filtering
    }
  }
}
