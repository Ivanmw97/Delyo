import 'package:flutter_test/flutter_test.dart';
import 'package:padel_tracker/domain/models/player.dart';

void main() {
  group('Player', () {
    test('should create a player with required fields', () {
      const player = Player(id: '1', name: 'John Doe');

      expect(player.id, equals('1'));
      expect(player.name, equals('John Doe'));
      expect(player.nickname, isNull);
    });

    test('should create a player with nickname', () {
      const player = Player(id: '1', name: 'John Doe', nickname: 'Johnny');

      expect(player.id, equals('1'));
      expect(player.name, equals('John Doe'));
      expect(player.nickname, equals('Johnny'));
    });

    test('should be equal when all fields match', () {
      const player1 = Player(id: '1', name: 'John Doe', nickname: 'Johnny');

      const player2 = Player(id: '1', name: 'John Doe', nickname: 'Johnny');

      expect(player1, equals(player2));
      expect(player1.hashCode, equals(player2.hashCode));
    });

    test('should not be equal when id differs', () {
      const player1 = Player(id: '1', name: 'John Doe');

      const player2 = Player(id: '2', name: 'John Doe');

      expect(player1, isNot(equals(player2)));
    });

    test('should not be equal when name differs', () {
      const player1 = Player(id: '1', name: 'John Doe');

      const player2 = Player(id: '1', name: 'Jane Doe');

      expect(player1, isNot(equals(player2)));
    });

    test('should not be equal when nickname differs', () {
      const player1 = Player(id: '1', name: 'John Doe', nickname: 'Johnny');

      const player2 = Player(id: '1', name: 'John Doe', nickname: 'JD');

      expect(player1, isNot(equals(player2)));
    });

    test('should not be equal when one has nickname and other does not', () {
      const player1 = Player(id: '1', name: 'John Doe', nickname: 'Johnny');

      const player2 = Player(id: '1', name: 'John Doe');

      expect(player1, isNot(equals(player2)));
    });

    test('toString should return formatted string', () {
      const player = Player(id: '1', name: 'John Doe', nickname: 'Johnny');

      expect(
        player.toString(),
        equals('Player(id: 1, name: John Doe, nickname: Johnny)'),
      );
    });

    test('toString should handle null nickname', () {
      const player = Player(id: '1', name: 'John Doe');

      expect(
        player.toString(),
        equals('Player(id: 1, name: John Doe, nickname: null)'),
      );
    });
  });
}
