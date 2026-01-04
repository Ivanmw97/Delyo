import 'package:padel_tracker/domain/enums/match_type.dart';
import 'package:padel_tracker/domain/enums/playing_side.dart';
import 'package:padel_tracker/domain/models/match_result.dart';
import 'package:padel_tracker/domain/models/player.dart';

/// Match entity
/// Represents a single padel match with all its details:
/// - match type (friendly, league, tournament)
/// - date and time
/// - playing side (right/left)
/// - partner and opponents
/// - match result (sets)
/// - subjective rating and notes
class Match {
  /// Unique identifier for the match
  final String id;

  /// Type of match (friendly, league, tournament)
  final MatchType matchType;

  /// Date and time when the match was played
  final DateTime dateTime;

  /// Side of the court the user played on
  final PlayingSide playingSide;

  /// User's partner in the match
  final Player partner;

  /// First opponent
  final Player opponent1;

  /// Second opponent
  final Player opponent2;

  /// Result of the match (sets and outcome)
  final MatchResult result;

  /// Subjective performance rating (1-5)
  final int? performanceRating;

  /// Optional notes about the match
  final String? notes;

  /// Duration of the match
  final Duration? duration;

  /// Location where the match was played
  final String? location;

  /// Creates a new [Match] instance
  const Match({
    required this.id,
    required this.matchType,
    required this.dateTime,
    required this.playingSide,
    required this.partner,
    required this.opponent1,
    required this.opponent2,
    required this.result,
    this.performanceRating,
    this.notes,
    this.duration,
    this.location,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Match &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          matchType == other.matchType &&
          dateTime == other.dateTime &&
          playingSide == other.playingSide &&
          partner == other.partner &&
          opponent1 == other.opponent1 &&
          opponent2 == other.opponent2 &&
          result == other.result &&
          performanceRating == other.performanceRating &&
          notes == other.notes &&
          duration == other.duration &&
          location == other.location;

  @override
  int get hashCode =>
      id.hashCode ^
      matchType.hashCode ^
      dateTime.hashCode ^
      playingSide.hashCode ^
      partner.hashCode ^
      opponent1.hashCode ^
      opponent2.hashCode ^
      result.hashCode ^
      performanceRating.hashCode ^
      notes.hashCode ^
      duration.hashCode ^
      location.hashCode;

  @override
  String toString() => 'Match(id: $id, type: $matchType, date: $dateTime)';
}
