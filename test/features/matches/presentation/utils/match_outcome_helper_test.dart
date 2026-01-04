import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:padel_tracker/domain/enums/match_type.dart';
import 'package:padel_tracker/domain/enums/playing_side.dart';
import 'package:padel_tracker/domain/models/match.dart';
import 'package:padel_tracker/domain/models/match_result.dart';
import 'package:padel_tracker/domain/models/padel_set.dart';
import 'package:padel_tracker/domain/models/player.dart';
import 'package:padel_tracker/features/matches/presentation/models/match_outcome.dart';
import 'package:padel_tracker/features/matches/presentation/utils/match_outcome_helper.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  group('Match Outcome Helper', () {
    const testPlayer1 = Player(id: '1', name: 'Partner');
    const testPlayer2 = Player(id: '2', name: 'Opponent 1');
    const testPlayer3 = Player(id: '3', name: 'Opponent 2');
    final testDateTime = DateTime(2025, 1, 15, 10, 0);

    // Helper function to create a test context with localization
    Widget createTestWidget({required Widget child}) {
      return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
        home: child,
      );
    }

    group('getMatchOutcome', () {
      test('should return win for friendly match when user won more sets', () {
        const result = MatchResult(
          sets: [
            PadelSet(userTeamGames: 6, opponentTeamGames: 4),
            PadelSet(userTeamGames: 6, opponentTeamGames: 3),
          ],
        );

        final match = Match(
          id: 'match1',
          matchType: MatchType.friendly,
          dateTime: testDateTime,
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: result,
        );

        expect(getMatchOutcome(match), equals(MatchOutcome.win));
      });

      test(
        'should return loss for friendly match when user lost more sets',
        () {
          const result = MatchResult(
            sets: [
              PadelSet(userTeamGames: 4, opponentTeamGames: 6),
              PadelSet(userTeamGames: 3, opponentTeamGames: 6),
            ],
          );

          final match = Match(
            id: 'match1',
            matchType: MatchType.friendly,
            dateTime: testDateTime,
            playingSide: PlayingSide.right,
            partner: testPlayer1,
            opponent1: testPlayer2,
            opponent2: testPlayer3,
            result: result,
          );

          expect(getMatchOutcome(match), equals(MatchOutcome.loss));
        },
      );

      test('should return draw for friendly match when sets are tied', () {
        const result = MatchResult(
          sets: [
            PadelSet(userTeamGames: 6, opponentTeamGames: 4),
            PadelSet(userTeamGames: 4, opponentTeamGames: 6),
          ],
        );

        final match = Match(
          id: 'match1',
          matchType: MatchType.friendly,
          dateTime: testDateTime,
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: result,
        );

        expect(getMatchOutcome(match), equals(MatchOutcome.draw));
      });

      test('should return win for league match when user won', () {
        const result = MatchResult(
          sets: [
            PadelSet(userTeamGames: 6, opponentTeamGames: 4),
            PadelSet(userTeamGames: 6, opponentTeamGames: 3),
          ],
        );

        final match = Match(
          id: 'match1',
          matchType: MatchType.league,
          dateTime: testDateTime,
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: result,
        );

        expect(getMatchOutcome(match), equals(MatchOutcome.win));
      });

      test('should return loss for league match when user lost', () {
        const result = MatchResult(
          sets: [
            PadelSet(userTeamGames: 4, opponentTeamGames: 6),
            PadelSet(userTeamGames: 3, opponentTeamGames: 6),
          ],
        );

        final match = Match(
          id: 'match1',
          matchType: MatchType.league,
          dateTime: testDateTime,
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: result,
        );

        expect(getMatchOutcome(match), equals(MatchOutcome.loss));
      });

      test('should return loss for league match even when sets are tied', () {
        // In official matches, tied sets still result in win/loss based on isMatchWon
        const result = MatchResult(
          sets: [
            PadelSet(userTeamGames: 6, opponentTeamGames: 4),
            PadelSet(userTeamGames: 4, opponentTeamGames: 6),
          ],
        );

        final match = Match(
          id: 'match1',
          matchType: MatchType.league,
          dateTime: testDateTime,
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: result,
        );

        // Since sets are tied (1-1), isMatchWon returns false
        expect(getMatchOutcome(match), equals(MatchOutcome.loss));
      });

      test('should return win for tournament match when user won', () {
        const result = MatchResult(
          sets: [
            PadelSet(userTeamGames: 6, opponentTeamGames: 4),
            PadelSet(userTeamGames: 6, opponentTeamGames: 3),
          ],
        );

        final match = Match(
          id: 'match1',
          matchType: MatchType.tournament,
          dateTime: testDateTime,
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: result,
        );

        expect(getMatchOutcome(match), equals(MatchOutcome.win));
      });

      test('should return loss for tournament match when user lost', () {
        const result = MatchResult(
          sets: [
            PadelSet(userTeamGames: 4, opponentTeamGames: 6),
            PadelSet(userTeamGames: 3, opponentTeamGames: 6),
          ],
        );

        final match = Match(
          id: 'match1',
          matchType: MatchType.tournament,
          dateTime: testDateTime,
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: result,
        );

        expect(getMatchOutcome(match), equals(MatchOutcome.loss));
      });
    });

    group('getMatchResultText', () {
      testWidgets('should return correct text for win', (
        WidgetTester tester,
      ) async {
        const result = MatchResult(
          sets: [
            PadelSet(userTeamGames: 6, opponentTeamGames: 4),
            PadelSet(userTeamGames: 6, opponentTeamGames: 3),
          ],
        );

        final match = Match(
          id: 'match1',
          matchType: MatchType.friendly,
          dateTime: testDateTime,
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: result,
        );

        await tester.pumpWidget(
          createTestWidget(
            child: Builder(
              builder: (context) {
                final resultText = getMatchResultText(match, context);
                expect(resultText, contains('2'));
                expect(resultText, contains('0'));
                return Container();
              },
            ),
          ),
        );
      });

      testWidgets('should return correct text for loss', (
        WidgetTester tester,
      ) async {
        const result = MatchResult(
          sets: [
            PadelSet(userTeamGames: 4, opponentTeamGames: 6),
            PadelSet(userTeamGames: 3, opponentTeamGames: 6),
          ],
        );

        final match = Match(
          id: 'match1',
          matchType: MatchType.friendly,
          dateTime: testDateTime,
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: result,
        );

        await tester.pumpWidget(
          createTestWidget(
            child: Builder(
              builder: (context) {
                final resultText = getMatchResultText(match, context);
                expect(resultText, contains('0'));
                expect(resultText, contains('2'));
                return Container();
              },
            ),
          ),
        );
      });

      testWidgets('should return correct text for draw', (
        WidgetTester tester,
      ) async {
        const result = MatchResult(
          sets: [
            PadelSet(userTeamGames: 6, opponentTeamGames: 4),
            PadelSet(userTeamGames: 4, opponentTeamGames: 6),
          ],
        );

        final match = Match(
          id: 'match1',
          matchType: MatchType.friendly,
          dateTime: testDateTime,
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: result,
        );

        await tester.pumpWidget(
          createTestWidget(
            child: Builder(
              builder: (context) {
                final resultText = getMatchResultText(match, context);
                expect(resultText, contains('1'));
                expect(resultText, contains('1'));
                return Container();
              },
            ),
          ),
        );
      });

      testWidgets('should return correct text for close win', (
        WidgetTester tester,
      ) async {
        const result = MatchResult(
          sets: [
            PadelSet(userTeamGames: 6, opponentTeamGames: 4),
            PadelSet(userTeamGames: 4, opponentTeamGames: 6),
            PadelSet(userTeamGames: 7, opponentTeamGames: 5),
          ],
        );

        final match = Match(
          id: 'match1',
          matchType: MatchType.tournament,
          dateTime: testDateTime,
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: result,
        );

        await tester.pumpWidget(
          createTestWidget(
            child: Builder(
              builder: (context) {
                final resultText = getMatchResultText(match, context);
                expect(resultText, contains('2'));
                expect(resultText, contains('1'));
                return Container();
              },
            ),
          ),
        );
      });
    });
  });
}
