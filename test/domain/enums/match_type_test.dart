import 'package:flutter_test/flutter_test.dart';
import 'package:padel_tracker/domain/enums/match_type.dart';

void main() {
  group('MatchType', () {
    test('should have all expected values', () {
      final allValues = MatchType.values;

      expect(allValues.length, equals(3));
      expect(allValues.contains(MatchType.friendly), isTrue);
      expect(allValues.contains(MatchType.league), isTrue);
      expect(allValues.contains(MatchType.tournament), isTrue);
    });

    test('should maintain consistent ordering', () {
      final values = MatchType.values;

      expect(values[0], equals(MatchType.friendly));
      expect(values[1], equals(MatchType.league));
      expect(values[2], equals(MatchType.tournament));
    });

    test('should have correct string representation', () {
      expect(MatchType.friendly.toString(), equals('MatchType.friendly'));
      expect(MatchType.league.toString(), equals('MatchType.league'));
      expect(MatchType.tournament.toString(), equals('MatchType.tournament'));
    });

    test('should support equality comparison', () {
      expect(MatchType.friendly, equals(MatchType.friendly));
      expect(MatchType.league, equals(MatchType.league));
      expect(MatchType.tournament, equals(MatchType.tournament));

      expect(MatchType.friendly, isNot(equals(MatchType.league)));
      expect(MatchType.league, isNot(equals(MatchType.tournament)));
      expect(MatchType.tournament, isNot(equals(MatchType.friendly)));
    });

    test('should support switch statements', () {
      String getMatchTypeDescription(MatchType type) {
        switch (type) {
          case MatchType.friendly:
            return 'Casual match with friends';
          case MatchType.league:
            return 'Competitive league match';
          case MatchType.tournament:
            return 'Tournament match';
        }
      }

      expect(
        getMatchTypeDescription(MatchType.friendly),
        equals('Casual match with friends'),
      );
      expect(
        getMatchTypeDescription(MatchType.league),
        equals('Competitive league match'),
      );
      expect(
        getMatchTypeDescription(MatchType.tournament),
        equals('Tournament match'),
      );
    });

    test('should support name property', () {
      expect(MatchType.friendly.name, equals('friendly'));
      expect(MatchType.league.name, equals('league'));
      expect(MatchType.tournament.name, equals('tournament'));
    });

    test('should support index property', () {
      expect(MatchType.friendly.index, equals(0));
      expect(MatchType.league.index, equals(1));
      expect(MatchType.tournament.index, equals(2));
    });
  });
}
