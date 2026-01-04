import 'package:flutter_test/flutter_test.dart';
import 'package:padel_tracker/domain/enums/match_type.dart';
import 'package:padel_tracker/domain/enums/playing_side.dart';
import 'package:padel_tracker/domain/models/match.dart';
import 'package:padel_tracker/domain/models/match_result.dart';
import 'package:padel_tracker/domain/models/padel_set.dart';
import 'package:padel_tracker/domain/models/player.dart';
import 'package:padel_tracker/features/matches/presentation/models/match_outcome.dart';
import 'package:padel_tracker/features/matches/presentation/utils/match_outcome_helper.dart';

/// Statistics calculation utilities for testing
class StatisticsCalculator {
  /// Calculate win rate as a percentage
  static double calculateWinRate(List<Match> matches) {
    if (matches.isEmpty) return 0.0;

    final wins = matches
        .where((match) => getMatchOutcome(match) == MatchOutcome.win)
        .length;

    return (wins / matches.length) * 100;
  }

  /// Calculate match type distribution
  static Map<MatchType, int> calculateMatchTypeDistribution(
    List<Match> matches,
  ) {
    final distribution = <MatchType, int>{
      MatchType.friendly: 0,
      MatchType.league: 0,
      MatchType.tournament: 0,
    };

    for (final match in matches) {
      distribution[match.matchType] = (distribution[match.matchType] ?? 0) + 1;
    }

    return distribution;
  }

  /// Calculate outcome distribution
  static Map<MatchOutcome, int> calculateOutcomeDistribution(
    List<Match> matches,
  ) {
    final distribution = <MatchOutcome, int>{
      MatchOutcome.win: 0,
      MatchOutcome.loss: 0,
      MatchOutcome.draw: 0,
    };

    for (final match in matches) {
      final outcome = getMatchOutcome(match);
      distribution[outcome] = (distribution[outcome] ?? 0) + 1;
    }

    return distribution;
  }

  /// Calculate average performance rating
  static double calculateAveragePerformanceRating(List<Match> matches) {
    final matchesWithRating = matches.where(
      (match) => match.performanceRating != null,
    );

    if (matchesWithRating.isEmpty) return 0.0;

    final totalRating = matchesWithRating
        .map((match) => match.performanceRating!)
        .reduce((a, b) => a + b);

    return totalRating / matchesWithRating.length;
  }

  /// Calculate playing side preference
  static Map<PlayingSide, int> calculatePlayingSideDistribution(
    List<Match> matches,
  ) {
    final distribution = <PlayingSide, int>{
      PlayingSide.left: 0,
      PlayingSide.right: 0,
    };

    for (final match in matches) {
      distribution[match.playingSide] =
          (distribution[match.playingSide] ?? 0) + 1;
    }

    return distribution;
  }

  /// Calculate win rate by match type
  static Map<MatchType, double> calculateWinRateByMatchType(
    List<Match> matches,
  ) {
    final winRates = <MatchType, double>{};

    for (final matchType in MatchType.values) {
      final matchesOfType = matches.where(
        (match) => match.matchType == matchType,
      );
      winRates[matchType] = calculateWinRate(matchesOfType.toList());
    }

    return winRates;
  }

  /// Calculate recent form (last N matches)
  static List<MatchOutcome> calculateRecentForm(
    List<Match> matches,
    int count,
  ) {
    // Sort matches by date (most recent first)
    final sortedMatches = List<Match>.from(matches)
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return sortedMatches
        .take(count)
        .map((match) => getMatchOutcome(match))
        .toList();
  }
}

void main() {
  group('Statistics Calculator', () {
    late List<Match> testMatches;
    const testPlayer1 = Player(id: '1', name: 'Partner');
    const testPlayer2 = Player(id: '2', name: 'Opponent 1');
    const testPlayer3 = Player(id: '3', name: 'Opponent 2');

    setUp(() {
      testMatches = [
        // Win - Friendly
        Match(
          id: 'match1',
          matchType: MatchType.friendly,
          dateTime: DateTime(2025, 1, 15),
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: const MatchResult(
            sets: [
              PadelSet(userTeamGames: 6, opponentTeamGames: 4),
              PadelSet(userTeamGames: 6, opponentTeamGames: 3),
            ],
          ),
          performanceRating: 4,
        ),
        // Loss - League
        Match(
          id: 'match2',
          matchType: MatchType.league,
          dateTime: DateTime(2025, 1, 14),
          playingSide: PlayingSide.left,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: const MatchResult(
            sets: [
              PadelSet(userTeamGames: 4, opponentTeamGames: 6),
              PadelSet(userTeamGames: 3, opponentTeamGames: 6),
            ],
          ),
          performanceRating: 2,
        ),
        // Draw - Friendly
        Match(
          id: 'match3',
          matchType: MatchType.friendly,
          dateTime: DateTime(2025, 1, 13),
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: const MatchResult(
            sets: [
              PadelSet(userTeamGames: 6, opponentTeamGames: 4),
              PadelSet(userTeamGames: 4, opponentTeamGames: 6),
            ],
          ),
          performanceRating: 3,
        ),
        // Win - Tournament
        Match(
          id: 'match4',
          matchType: MatchType.tournament,
          dateTime: DateTime(2025, 1, 12),
          playingSide: PlayingSide.left,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: const MatchResult(
            sets: [
              PadelSet(userTeamGames: 7, opponentTeamGames: 5),
              PadelSet(userTeamGames: 6, opponentTeamGames: 4),
            ],
          ),
          performanceRating: 5,
        ),
      ];
    });

    group('calculateWinRate', () {
      test('should return 0 for empty match list', () {
        expect(StatisticsCalculator.calculateWinRate([]), equals(0.0));
      });

      test('should calculate correct win rate', () {
        // 2 wins out of 4 matches = 50%
        final winRate = StatisticsCalculator.calculateWinRate(testMatches);
        expect(winRate, equals(50.0));
      });

      test('should handle all wins', () {
        final allWins = testMatches
            .where((match) => getMatchOutcome(match) == MatchOutcome.win)
            .toList();

        final winRate = StatisticsCalculator.calculateWinRate(allWins);
        expect(winRate, equals(100.0));
      });

      test('should handle all losses', () {
        final allLosses = testMatches
            .where((match) => getMatchOutcome(match) == MatchOutcome.loss)
            .toList();

        final winRate = StatisticsCalculator.calculateWinRate(allLosses);
        expect(winRate, equals(0.0));
      });
    });

    group('calculateMatchTypeDistribution', () {
      test('should return correct distribution', () {
        final distribution =
            StatisticsCalculator.calculateMatchTypeDistribution(testMatches);

        expect(distribution[MatchType.friendly], equals(2));
        expect(distribution[MatchType.league], equals(1));
        expect(distribution[MatchType.tournament], equals(1));
      });

      test('should handle empty match list', () {
        final distribution =
            StatisticsCalculator.calculateMatchTypeDistribution([]);

        expect(distribution[MatchType.friendly], equals(0));
        expect(distribution[MatchType.league], equals(0));
        expect(distribution[MatchType.tournament], equals(0));
      });

      test('should handle single match type', () {
        final friendlyMatches = testMatches
            .where((match) => match.matchType == MatchType.friendly)
            .toList();

        final distribution =
            StatisticsCalculator.calculateMatchTypeDistribution(
              friendlyMatches,
            );

        expect(distribution[MatchType.friendly], equals(2));
        expect(distribution[MatchType.league], equals(0));
        expect(distribution[MatchType.tournament], equals(0));
      });
    });

    group('calculateOutcomeDistribution', () {
      test('should return correct outcome distribution', () {
        final distribution = StatisticsCalculator.calculateOutcomeDistribution(
          testMatches,
        );

        expect(distribution[MatchOutcome.win], equals(2));
        expect(distribution[MatchOutcome.loss], equals(1));
        expect(distribution[MatchOutcome.draw], equals(1));
      });

      test('should handle empty match list', () {
        final distribution = StatisticsCalculator.calculateOutcomeDistribution(
          [],
        );

        expect(distribution[MatchOutcome.win], equals(0));
        expect(distribution[MatchOutcome.loss], equals(0));
        expect(distribution[MatchOutcome.draw], equals(0));
      });
    });

    group('calculateAveragePerformanceRating', () {
      test('should calculate correct average', () {
        // Ratings: 4, 2, 3, 5 = average 3.5
        final average = StatisticsCalculator.calculateAveragePerformanceRating(
          testMatches,
        );
        expect(average, equals(3.5));
      });

      test('should return 0 for empty match list', () {
        final average = StatisticsCalculator.calculateAveragePerformanceRating(
          [],
        );
        expect(average, equals(0.0));
      });

      test('should handle matches without ratings', () {
        final matchWithoutRating = Match(
          id: 'no-rating',
          matchType: MatchType.friendly,
          dateTime: DateTime(2025, 1, 11),
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: const MatchResult(
            sets: [PadelSet(userTeamGames: 6, opponentTeamGames: 4)],
          ),
        );

        final matchesWithMixed = [...testMatches, matchWithoutRating];
        final average = StatisticsCalculator.calculateAveragePerformanceRating(
          matchesWithMixed,
        );

        // Should still be 3.5 (ignoring the match without rating)
        expect(average, equals(3.5));
      });

      test('should return 0 when no matches have ratings', () {
        final matchesWithoutRatings = testMatches
            .map(
              (match) => Match(
                id: match.id,
                matchType: match.matchType,
                dateTime: match.dateTime,
                playingSide: match.playingSide,
                partner: match.partner,
                opponent1: match.opponent1,
                opponent2: match.opponent2,
                result: match.result,
              ),
            )
            .toList();

        final average = StatisticsCalculator.calculateAveragePerformanceRating(
          matchesWithoutRatings,
        );
        expect(average, equals(0.0));
      });
    });

    group('calculatePlayingSideDistribution', () {
      test('should return correct side distribution', () {
        final distribution =
            StatisticsCalculator.calculatePlayingSideDistribution(testMatches);

        expect(distribution[PlayingSide.right], equals(2));
        expect(distribution[PlayingSide.left], equals(2));
      });

      test('should handle empty match list', () {
        final distribution =
            StatisticsCalculator.calculatePlayingSideDistribution([]);

        expect(distribution[PlayingSide.right], equals(0));
        expect(distribution[PlayingSide.left], equals(0));
      });
    });

    group('calculateWinRateByMatchType', () {
      test('should calculate win rates by match type', () {
        final winRates = StatisticsCalculator.calculateWinRateByMatchType(
          testMatches,
        );

        // Friendly: 1 win, 1 draw = 50% win rate
        expect(winRates[MatchType.friendly], equals(50.0));
        // League: 0 wins, 1 loss = 0% win rate
        expect(winRates[MatchType.league], equals(0.0));
        // Tournament: 1 win = 100% win rate
        expect(winRates[MatchType.tournament], equals(100.0));
      });

      test('should handle match types with no matches', () {
        final singleMatch = [testMatches.first];
        final winRates = StatisticsCalculator.calculateWinRateByMatchType(
          singleMatch,
        );

        expect(winRates[MatchType.friendly], equals(100.0));
        expect(winRates[MatchType.league], equals(0.0));
        expect(winRates[MatchType.tournament], equals(0.0));
      });
    });

    group('calculateRecentForm', () {
      test('should return recent form in chronological order', () {
        final recentForm = StatisticsCalculator.calculateRecentForm(
          testMatches,
          3,
        );

        // Should be ordered by most recent first
        expect(recentForm.length, equals(3));
        expect(recentForm[0], equals(MatchOutcome.win)); // match1 (Jan 15)
        expect(recentForm[1], equals(MatchOutcome.loss)); // match2 (Jan 14)
        expect(recentForm[2], equals(MatchOutcome.draw)); // match3 (Jan 13)
      });

      test('should handle requesting more matches than available', () {
        final recentForm = StatisticsCalculator.calculateRecentForm(
          testMatches,
          10,
        );

        expect(recentForm.length, equals(4)); // Only 4 matches available
      });

      test('should handle empty match list', () {
        final recentForm = StatisticsCalculator.calculateRecentForm([], 5);

        expect(recentForm, isEmpty);
      });

      test('should handle requesting zero matches', () {
        final recentForm = StatisticsCalculator.calculateRecentForm(
          testMatches,
          0,
        );

        expect(recentForm, isEmpty);
      });
    });
  });
}
