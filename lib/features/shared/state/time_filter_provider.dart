import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padel_tracker/domain/enums/time_range.dart';

/// Global time range filter provider
///
/// Manages the currently selected time range for filtering matches
/// across all views in the application.
final timeRangeProvider = StateProvider<TimeRange>((ref) {
  return TimeRange.lastMonth; // Default to last month
});
