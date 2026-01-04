import 'package:flutter_test/flutter_test.dart';
import 'package:padel_tracker/domain/models/match.dart';
import 'package:padel_tracker/domain/models/match_result.dart';
import 'package:padel_tracker/domain/models/padel_set.dart';
import 'package:padel_tracker/domain/models/player.dart';
import 'package:padel_tracker/domain/enums/match_type.dart';
import 'package:padel_tracker/domain/enums/playing_side.dart';
import 'package:padel_tracker/domain/enums/time_range.dart';

// Import the private function for testing
List<Match> filterMatchesByTimeRange(List<Match> matches, TimeRange timeRange) {
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

void main() {
  group('Filtered Matches Logic', () {
    late List<Match> testMatches;
    final now = DateTime.now();

    setUp(() {
      const testPlayer1 = Player(id: '1', name: 'Partner');
      const testPlayer2 = Player(id: '2', name: 'Opponent 1');
      const testPlayer3 = Player(id: '3', name: 'Opponent 2');
      const testResult = MatchResult(
        sets: [PadelSet(userTeamGames: 6, opponentTeamGames: 4)],
      );

      testMatches = [
        // Match from current month (day 15 of current month)
        Match(
          id: 'match1',
          matchType: MatchType.friendly,
          dateTime: DateTime(now.year, now.month, 15),
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: testResult,
        ),
        // Match from 2 months ago
        Match(
          id: 'match2',
          matchType: MatchType.league,
          dateTime: DateTime(now.year, now.month - 2, 15),
          playingSide: PlayingSide.left,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: testResult,
        ),
        // Match from 6 months ago
        Match(
          id: 'match3',
          matchType: MatchType.tournament,
          dateTime: DateTime(now.year, now.month - 6, 10),
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: testResult,
        ),
        // Match from 2 years ago
        Match(
          id: 'match4',
          matchType: MatchType.friendly,
          dateTime: DateTime(now.year - 2, now.month, 20),
          playingSide: PlayingSide.left,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: testResult,
        ),
      ];
    });

    test('should return all matches for allTime filter', () {
      final filtered = filterMatchesByTimeRange(testMatches, TimeRange.allTime);

      expect(filtered.length, equals(4));
      expect(filtered, containsAll(testMatches));
    });

    test('should filter matches for lastMonth', () {
      final filtered = filterMatchesByTimeRange(
        testMatches,
        TimeRange.lastMonth,
      );

      // Should only include matches from the current calendar month (2 weeks ago match)
      expect(filtered.length, equals(1));
      expect(filtered.first.id, equals('match1'));
    });

    test('should filter matches for lastThreeMonths', () {
      final filtered = filterMatchesByTimeRange(
        testMatches,
        TimeRange.lastThreeMonths,
      );

      // Should include matches from last 3 months (2 weeks and 2 months ago)
      expect(filtered.length, equals(2));
      expect(filtered.map((m) => m.id), containsAll(['match1', 'match2']));
    });

    test('should filter matches for lastYear', () {
      final filtered = filterMatchesByTimeRange(
        testMatches,
        TimeRange.lastYear,
      );

      // Should include matches from last year (2 weeks, 2 months, and 6 months ago)
      expect(filtered.length, equals(3));
      expect(
        filtered.map((m) => m.id),
        containsAll(['match1', 'match2', 'match3']),
      );
    });

    test('should handle empty match list', () {
      final filtered = filterMatchesByTimeRange([], TimeRange.lastMonth);

      expect(filtered, isEmpty);
    });

    test('should handle matches exactly at boundary', () {
      const testPlayer1 = Player(id: '1', name: 'Partner');
      const testPlayer2 = Player(id: '2', name: 'Opponent 1');
      const testPlayer3 = Player(id: '3', name: 'Opponent 2');
      const testResult = MatchResult(
        sets: [PadelSet(userTeamGames: 6, opponentTeamGames: 4)],
      );

      final boundaryDate = TimeRange.lastMonth.startDate!;

      final matchAtBoundary = Match(
        id: 'boundary',
        matchType: MatchType.friendly,
        dateTime: boundaryDate,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      final matchAfterBoundary = Match(
        id: 'after',
        matchType: MatchType.friendly,
        dateTime: boundaryDate.add(Duration(minutes: 1)),
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      final matches = [matchAtBoundary, matchAfterBoundary];
      final filtered = filterMatchesByTimeRange(matches, TimeRange.lastMonth);

      // Should include both matches (boundary match and after boundary match)
      expect(filtered.length, equals(2));
      expect(filtered.map((m) => m.id), containsAll(['boundary', 'after']));
    });

    test('should preserve match order after filtering', () {
      final filtered = filterMatchesByTimeRange(
        testMatches,
        TimeRange.lastYear,
      );

      // Should maintain original order
      expect(filtered[0].id, equals('match1'));
      expect(filtered[1].id, equals('match2'));
      expect(filtered[2].id, equals('match3'));
    });

    test('should handle all matches being outside filter range', () {
      const testPlayer1 = Player(id: '1', name: 'Partner');
      const testPlayer2 = Player(id: '2', name: 'Opponent 1');
      const testPlayer3 = Player(id: '3', name: 'Opponent 2');
      const testResult = MatchResult(
        sets: [PadelSet(userTeamGames: 6, opponentTeamGames: 4)],
      );

      final oldMatches = [
        Match(
          id: 'old1',
          matchType: MatchType.friendly,
          dateTime: DateTime(2020, 1, 1),
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: testResult,
        ),
        Match(
          id: 'old2',
          matchType: MatchType.league,
          dateTime: DateTime(2019, 6, 15),
          playingSide: PlayingSide.left,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: testResult,
        ),
      ];

      final filtered = filterMatchesByTimeRange(
        oldMatches,
        TimeRange.lastMonth,
      );

      expect(filtered, isEmpty);
    });
  });
}
