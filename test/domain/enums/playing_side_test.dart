import 'package:flutter_test/flutter_test.dart';
import 'package:padel_tracker/domain/enums/playing_side.dart';

void main() {
  group('PlayingSide', () {
    test('should have all expected values', () {
      final allValues = PlayingSide.values;

      expect(allValues.length, equals(2));
      expect(allValues.contains(PlayingSide.right), isTrue);
      expect(allValues.contains(PlayingSide.left), isTrue);
    });

    test('should maintain consistent ordering', () {
      final values = PlayingSide.values;

      expect(values[0], equals(PlayingSide.right));
      expect(values[1], equals(PlayingSide.left));
    });

    test('should have correct string representation', () {
      expect(PlayingSide.right.toString(), equals('PlayingSide.right'));
      expect(PlayingSide.left.toString(), equals('PlayingSide.left'));
    });

    test('should support equality comparison', () {
      expect(PlayingSide.right, equals(PlayingSide.right));
      expect(PlayingSide.left, equals(PlayingSide.left));

      expect(PlayingSide.right, isNot(equals(PlayingSide.left)));
      expect(PlayingSide.left, isNot(equals(PlayingSide.right)));
    });

    test('should support switch statements', () {
      String getSideDescription(PlayingSide side) {
        switch (side) {
          case PlayingSide.right:
            return 'Right side of the court';
          case PlayingSide.left:
            return 'Left side of the court';
        }
      }

      expect(
        getSideDescription(PlayingSide.right),
        equals('Right side of the court'),
      );
      expect(
        getSideDescription(PlayingSide.left),
        equals('Left side of the court'),
      );
    });

    test('should support name property', () {
      expect(PlayingSide.right.name, equals('right'));
      expect(PlayingSide.left.name, equals('left'));
    });

    test('should support index property', () {
      expect(PlayingSide.right.index, equals(0));
      expect(PlayingSide.left.index, equals(1));
    });

    test('should support opposite side logic', () {
      PlayingSide getOppositeSide(PlayingSide side) {
        return side == PlayingSide.right ? PlayingSide.left : PlayingSide.right;
      }

      expect(getOppositeSide(PlayingSide.right), equals(PlayingSide.left));
      expect(getOppositeSide(PlayingSide.left), equals(PlayingSide.right));
    });
  });
}
