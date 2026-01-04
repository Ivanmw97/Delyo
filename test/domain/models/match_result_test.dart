import 'package:flutter_test/flutter_test.dart';
import 'package:padel_tracker/domain/models/match_result.dart';
import 'package:padel_tracker/domain/models/padel_set.dart';

void main() {
  group('MatchResult', () {
    test('should create a match result with sets', () {
      const result = MatchResult(
        sets: [
          PadelSet(userTeamGames: 6, opponentTeamGames: 4),
          PadelSet(userTeamGames: 6, opponentTeamGames: 3),
        ],
      );

      expect(result.sets.length, equals(2));
      expect(result.sets[0].userTeamGames, equals(6));
      expect(result.sets[1].userTeamGames, equals(6));
    });

    test('isMatchWon should return true when user won more sets', () {
      const result = MatchResult(
        sets: [
          PadelSet(userTeamGames: 6, opponentTeamGames: 4),
          PadelSet(userTeamGames: 6, opponentTeamGames: 3),
          PadelSet(userTeamGames: 4, opponentTeamGames: 6),
        ],
      );

      expect(result.isMatchWon, isTrue);
    });

    test('isMatchWon should return false when user lost more sets', () {
      const result = MatchResult(
        sets: [
          PadelSet(userTeamGames: 4, opponentTeamGames: 6),
          PadelSet(userTeamGames: 3, opponentTeamGames: 6),
          PadelSet(userTeamGames: 6, opponentTeamGames: 4),
        ],
      );

      expect(result.isMatchWon, isFalse);
    });

    test('isMatchWon should return false when sets are tied', () {
      const result = MatchResult(
        sets: [
          PadelSet(userTeamGames: 6, opponentTeamGames: 4),
          PadelSet(userTeamGames: 4, opponentTeamGames: 6),
        ],
      );

      expect(result.isMatchWon, isFalse);
    });

    test('setsWon should return correct count', () {
      const result = MatchResult(
        sets: [
          PadelSet(userTeamGames: 6, opponentTeamGames: 4),
          PadelSet(userTeamGames: 6, opponentTeamGames: 3),
          PadelSet(userTeamGames: 4, opponentTeamGames: 6),
        ],
      );

      expect(result.setsWon, equals(2));
    });

    test('setsLost should return correct count', () {
      const result = MatchResult(
        sets: [
          PadelSet(userTeamGames: 6, opponentTeamGames: 4),
          PadelSet(userTeamGames: 6, opponentTeamGames: 3),
          PadelSet(userTeamGames: 4, opponentTeamGames: 6),
        ],
      );

      expect(result.setsLost, equals(1));
    });

    test('should handle match with no sets won', () {
      const result = MatchResult(
        sets: [
          PadelSet(userTeamGames: 4, opponentTeamGames: 6),
          PadelSet(userTeamGames: 3, opponentTeamGames: 6),
        ],
      );

      expect(result.setsWon, equals(0));
      expect(result.setsLost, equals(2));
      expect(result.isMatchWon, isFalse);
    });

    test('should handle match with all sets won', () {
      const result = MatchResult(
        sets: [
          PadelSet(userTeamGames: 6, opponentTeamGames: 4),
          PadelSet(userTeamGames: 6, opponentTeamGames: 3),
        ],
      );

      expect(result.setsWon, equals(2));
      expect(result.setsLost, equals(0));
      expect(result.isMatchWon, isTrue);
    });

    test('should handle single set match', () {
      const result = MatchResult(
        sets: [PadelSet(userTeamGames: 6, opponentTeamGames: 4)],
      );

      expect(result.setsWon, equals(1));
      expect(result.setsLost, equals(0));
      expect(result.isMatchWon, isTrue);
    });

    test('should handle empty sets list', () {
      const result = MatchResult(sets: []);

      expect(result.setsWon, equals(0));
      expect(result.setsLost, equals(0));
      expect(result.isMatchWon, isFalse);
    });

    test('should be equal when sets match', () {
      const result1 = MatchResult(
        sets: [
          PadelSet(userTeamGames: 6, opponentTeamGames: 4),
          PadelSet(userTeamGames: 6, opponentTeamGames: 3),
        ],
      );

      const result2 = MatchResult(
        sets: [
          PadelSet(userTeamGames: 6, opponentTeamGames: 4),
          PadelSet(userTeamGames: 6, opponentTeamGames: 3),
        ],
      );

      expect(result1, equals(result2));
      expect(result1.hashCode, equals(result2.hashCode));
    });

    test('should not be equal when sets differ', () {
      const result1 = MatchResult(
        sets: [PadelSet(userTeamGames: 6, opponentTeamGames: 4)],
      );

      const result2 = MatchResult(
        sets: [PadelSet(userTeamGames: 6, opponentTeamGames: 3)],
      );

      expect(result1, isNot(equals(result2)));
    });

    test('should not be equal when number of sets differ', () {
      const result1 = MatchResult(
        sets: [PadelSet(userTeamGames: 6, opponentTeamGames: 4)],
      );

      const result2 = MatchResult(
        sets: [
          PadelSet(userTeamGames: 6, opponentTeamGames: 4),
          PadelSet(userTeamGames: 6, opponentTeamGames: 3),
        ],
      );

      expect(result1, isNot(equals(result2)));
    });

    test('toString should include sets and match outcome', () {
      const result = MatchResult(
        sets: [PadelSet(userTeamGames: 6, opponentTeamGames: 4)],
      );

      final str = result.toString();
      expect(str, contains('MatchResult'));
      expect(str, contains('sets'));
      expect(str, contains('won'));
    });
  });
}
