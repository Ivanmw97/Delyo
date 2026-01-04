import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padel_tracker/domain/models/match.dart';
import 'package:padel_tracker/domain/repositories/match_repository.dart';
import 'package:padel_tracker/features/matches/state/matches_state.dart';

/// StateNotifier for managing matches
///
/// Handles all match-related operations including loading, adding, and deleting matches.
/// Manages loading and error states appropriately.
class MatchesNotifier extends StateNotifier<MatchesState> {
  final MatchRepository _repository;

  MatchesNotifier(this._repository) : super(const MatchesState.initial());

  /// Loads all matches from the repository
  Future<void> loadMatches() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final matches = await _repository.getAllMatches();
      state = MatchesState(matches: matches, isLoading: false, error: null);
    } catch (e) {
      state = MatchesState(
        matches: const [],
        isLoading: false,
        error: 'Failed to load matches: ${e.toString()}',
      );
    }
  }

  /// Adds a new match or updates an existing one
  Future<void> addMatch(Match match) async {
    try {
      await _repository.saveMatch(match);
      await loadMatches();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to save match: ${e.toString()}',
      );
    }
  }

  /// Updates an existing match
  Future<void> updateMatch(Match match) async {
    try {
      await _repository.saveMatch(match);
      await loadMatches();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to update match: ${e.toString()}',
      );
    }
  }

  /// Deletes a match by its ID
  Future<void> deleteMatch(String matchId) async {
    try {
      await _repository.deleteMatch(matchId);
      await loadMatches();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to delete match: ${e.toString()}',
      );
    }
  }

  /// Clears all matches
  Future<void> clearAllMatches() async {
    try {
      await _repository.clearAll();
      state = const MatchesState(matches: [], isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to clear matches: ${e.toString()}',
      );
    }
  }
}
