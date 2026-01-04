import 'package:padel_tracker/domain/models/padel_set.dart';

/// Match result entity
/// Aggregates the outcome of a match
/// Contains sets and overall win/loss status
class MatchResult {
  /// List of sets played in the match
  final List<PadelSet> sets;

  /// Creates a new [MatchResult] instance
  const MatchResult({required this.sets});

  /// Returns true if the user's team won the match
  bool get isMatchWon {
    final wonSets = sets.where((set) => set.isWon).length;
    final lostSets = sets.length - wonSets;
    return wonSets > lostSets;
  }

  /// Returns the number of sets won by the user's team
  int get setsWon => sets.where((set) => set.isWon).length;

  /// Returns the number of sets lost by the user's team
  int get setsLost => sets.length - setsWon;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchResult &&
          runtimeType == other.runtimeType &&
          _listEquals(sets, other.sets);

  @override
  int get hashCode => sets.fold(0, (hash, set) => hash ^ set.hashCode);

  @override
  String toString() => 'MatchResult(sets: $sets, won: $isMatchWon)';

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
