import 'package:padel_tracker/domain/models/match.dart';

/// Immutable state for matches
///
/// Represents the current state of the matches list including
/// loading status and potential errors.
class MatchesState {
  /// List of matches
  final List<Match> matches;

  /// Whether matches are currently being loaded
  final bool isLoading;

  /// Error message if an error occurred, null otherwise
  final String? error;

  const MatchesState({
    required this.matches,
    required this.isLoading,
    this.error,
  });

  /// Initial state with empty matches
  const MatchesState.initial()
    : matches = const [],
      isLoading = false,
      error = null;

  /// Loading state
  const MatchesState.loading()
    : matches = const [],
      isLoading = true,
      error = null;

  /// Creates a copy with updated fields
  MatchesState copyWith({
    List<Match>? matches,
    bool? isLoading,
    String? error,
  }) {
    return MatchesState(
      matches: matches ?? this.matches,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchesState &&
          runtimeType == other.runtimeType &&
          _listEquals(matches, other.matches) &&
          isLoading == other.isLoading &&
          error == other.error;

  @override
  int get hashCode => matches.hashCode ^ isLoading.hashCode ^ error.hashCode;

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
