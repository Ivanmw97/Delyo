import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padel_tracker/domain/models/match.dart';
import 'package:padel_tracker/domain/enums/time_range.dart';
import 'package:padel_tracker/features/matches/state/matches_provider.dart';
import 'package:padel_tracker/features/shared/state/time_filter_provider.dart';

/// Filtered matches provider
///
/// Combines the matches data with the selected time range filter
/// to provide filtered match results to all views.
final filteredMatchesProvider = Provider<List<Match>>((ref) {
  final matchesState = ref.watch(matchesProvider);
  final timeRange = ref.watch(timeRangeProvider);

  if (matchesState.isLoading || matchesState.error != null) {
    return [];
  }

  return _filterMatchesByTimeRange(matchesState.matches, timeRange);
});

/// Filters matches based on the selected time range
///
/// Returns all matches if timeRange is allTime, otherwise filters
/// matches to only include those within the time range boundaries.
List<Match> _filterMatchesByTimeRange(
  List<Match> matches,
  TimeRange timeRange,
) {
  final startDate = timeRange.startDate;
  final endDate = timeRange.endDate;

  if (startDate == null || endDate == null) {
    return matches; // All time - no filtering
  }

  return matches.where((match) {
    final matchDate = match.dateTime;
    return matchDate.isAtSameOrAfter(startDate) &&
        matchDate.isAtSameOrBefore(endDate);
  }).toList();
}

/// Extension to add isAtSameOrAfter and isAtSameOrBefore methods to DateTime
extension DateTimeComparison on DateTime {
  bool isAtSameOrAfter(DateTime other) {
    return isAfter(other) || isAtSameMomentAs(other);
  }

  bool isAtSameOrBefore(DateTime other) {
    return isBefore(other) || isAtSameMomentAs(other);
  }
}
