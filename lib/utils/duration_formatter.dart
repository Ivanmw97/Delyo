import 'package:flutter/widgets.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';

/// Utility class for formatting Duration objects
class DurationFormatter {
  /// Formats a Duration to a human-readable string like "1h 15m"
  /// Returns null if duration is null
  static String? formatDuration(Duration? duration, BuildContext context) {
    if (duration == null) return null;

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0 && minutes > 0) {
      return AppLocalizations.of(context)!.hoursAndMinutes(hours, minutes);
    } else if (hours > 0) {
      return AppLocalizations.of(context)!.hoursShort(hours);
    } else if (minutes > 0) {
      return AppLocalizations.of(context)!.minutesShort(minutes);
    } else {
      return AppLocalizations.of(context)!.zeroMinutes;
    }
  }

  /// Formats a Duration to a human-readable string with fallback
  /// Returns the fallback string if duration is null
  static String formatDurationWithFallback(
    Duration? duration,
    BuildContext context,
    String fallback,
  ) {
    return formatDuration(duration, context) ?? fallback;
  }
}
