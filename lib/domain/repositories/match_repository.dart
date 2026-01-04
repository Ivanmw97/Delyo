import 'package:padel_tracker/domain/models/match.dart';

/// Repository contract for managing padel matches
///
/// This interface defines the contract for match persistence operations.
/// Implementations should handle the conversion between domain models
/// and their persistence format.
abstract class MatchRepository {
  /// Retrieves all matches from the repository
  ///
  /// Returns a list of all stored matches, ordered by date (newest first).
  /// Returns an empty list if no matches are found.
  Future<List<Match>> getAllMatches();

  /// Retrieves a specific match by its unique identifier
  ///
  /// Returns the [Match] if found, or `null` if no match exists
  /// with the given [id].
  Future<Match?> getMatchById(String id);

  /// Saves a match to the repository
  ///
  /// If a match with the same [match.id] already exists, it will be replaced.
  /// Otherwise, a new match entry will be created.
  Future<void> saveMatch(Match match);

  /// Deletes a match from the repository
  ///
  /// Removes the match with the given [matchId].
  /// Does nothing if no match with that id exists.
  Future<void> deleteMatch(String matchId);

  /// Clears all matches from the repository
  ///
  /// Removes all stored matches. This operation cannot be undone.
  Future<void> clearAll();
}
