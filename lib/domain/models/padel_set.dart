/// Padel set entity
/// Represents a single set within a match
/// Contains score information for both teams
class PadelSet {
  /// Games won by the user's team
  final int userTeamGames;

  /// Games won by the opponent team
  final int opponentTeamGames;

  /// Creates a new [PadelSet] instance
  const PadelSet({
    required this.userTeamGames,
    required this.opponentTeamGames,
  });

  /// Returns true if the user's team won this set
  bool get isWon => userTeamGames > opponentTeamGames;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PadelSet &&
          runtimeType == other.runtimeType &&
          userTeamGames == other.userTeamGames &&
          opponentTeamGames == other.opponentTeamGames;

  @override
  int get hashCode => userTeamGames.hashCode ^ opponentTeamGames.hashCode;

  @override
  String toString() => 'PadelSet($userTeamGames-$opponentTeamGames)';
}
