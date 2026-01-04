import 'package:flutter_test/flutter_test.dart';
import 'package:padel_tracker/domain/models/padel_set.dart';

void main() {
  group('PadelSet', () {
    test('should create a set with game scores', () {
      const set = PadelSet(userTeamGames: 6, opponentTeamGames: 4);

      expect(set.userTeamGames, equals(6));
      expect(set.opponentTeamGames, equals(4));
    });

    test('isWon should return true when user team won', () {
      const set = PadelSet(userTeamGames: 6, opponentTeamGames: 4);

      expect(set.isWon, isTrue);
    });

    test('isWon should return false when user team lost', () {
      const set = PadelSet(userTeamGames: 4, opponentTeamGames: 6);

      expect(set.isWon, isFalse);
    });

    test('isWon should return false when scores are tied', () {
      const set = PadelSet(userTeamGames: 5, opponentTeamGames: 5);

      expect(set.isWon, isFalse);
    });

    test('should handle zero scores', () {
      const set = PadelSet(userTeamGames: 0, opponentTeamGames: 6);

      expect(set.userTeamGames, equals(0));
      expect(set.opponentTeamGames, equals(6));
      expect(set.isWon, isFalse);
    });

    test('should be equal when scores match', () {
      const set1 = PadelSet(userTeamGames: 6, opponentTeamGames: 4);

      const set2 = PadelSet(userTeamGames: 6, opponentTeamGames: 4);

      expect(set1, equals(set2));
      expect(set1.hashCode, equals(set2.hashCode));
    });

    test('should not be equal when user team games differ', () {
      const set1 = PadelSet(userTeamGames: 6, opponentTeamGames: 4);

      const set2 = PadelSet(userTeamGames: 7, opponentTeamGames: 4);

      expect(set1, isNot(equals(set2)));
    });

    test('should not be equal when opponent team games differ', () {
      const set1 = PadelSet(userTeamGames: 6, opponentTeamGames: 4);

      const set2 = PadelSet(userTeamGames: 6, opponentTeamGames: 3);

      expect(set1, isNot(equals(set2)));
    });

    test('toString should return formatted string', () {
      const set = PadelSet(userTeamGames: 6, opponentTeamGames: 4);

      expect(set.toString(), equals('PadelSet(6-4)'));
    });

    test('should handle tiebreak scores', () {
      const set = PadelSet(userTeamGames: 7, opponentTeamGames: 6);

      expect(set.userTeamGames, equals(7));
      expect(set.opponentTeamGames, equals(6));
      expect(set.isWon, isTrue);
    });
  });
}
