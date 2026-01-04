import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:padel_tracker/data/hive/hive_boxes.dart';
import 'package:padel_tracker/data/models/match_entity.dart';
import 'package:padel_tracker/data/models/match_result_entity.dart';
import 'package:padel_tracker/data/models/padel_set_entity.dart';
import 'package:padel_tracker/data/models/player_entity.dart';
import 'package:padel_tracker/data/repositories/match_repository_hive.dart';
import 'package:padel_tracker/domain/enums/match_type.dart';
import 'package:padel_tracker/domain/enums/playing_side.dart';
import 'package:padel_tracker/domain/models/match.dart';
import 'package:padel_tracker/domain/models/match_result.dart';
import 'package:padel_tracker/domain/models/padel_set.dart';
import 'package:padel_tracker/domain/models/player.dart';

void main() {
  group('MatchRepositoryHive', () {
    late MatchRepositoryHive repository;
    late Directory testDir;

    setUp(() async {
      // Create a temporary directory for Hive
      testDir = await Directory.systemTemp.createTemp('hive_test_');

      // Initialize Hive with the temporary directory
      Hive.init(testDir.path);

      // Register all adapters
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(PlayerEntityAdapter());
      }
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(PadelSetEntityAdapter());
      }
      if (!Hive.isAdapterRegistered(2)) {
        Hive.registerAdapter(MatchResultEntityAdapter());
      }
      if (!Hive.isAdapterRegistered(3)) {
        Hive.registerAdapter(MatchEntityAdapter());
      }

      // Open boxes
      await HiveBoxes.openBoxes();

      // Create repository instance
      repository = MatchRepositoryHive();
    });

    tearDown(() async {
      // Close all boxes
      await Hive.close();

      // Delete the temporary directory
      if (testDir.existsSync()) {
        await testDir.delete(recursive: true);
      }
    });

    Match createTestMatch({
      String id = 'match1',
      MatchType matchType = MatchType.friendly,
      DateTime? dateTime,
      PlayingSide playingSide = PlayingSide.right,
      int? performanceRating,
      String? notes,
    }) {
      return Match(
        id: id,
        matchType: matchType,
        dateTime: dateTime ?? DateTime(2025, 1, 15, 10, 0),
        playingSide: playingSide,
        partner: const Player(id: 'p1', name: 'Partner'),
        opponent1: const Player(id: 'o1', name: 'Opponent 1'),
        opponent2: const Player(id: 'o2', name: 'Opponent 2'),
        result: const MatchResult(
          sets: [
            PadelSet(userTeamGames: 6, opponentTeamGames: 4),
            PadelSet(userTeamGames: 6, opponentTeamGames: 3),
          ],
        ),
        performanceRating: performanceRating,
        notes: notes,
      );
    }

    test('saveMatch should persist a match', () async {
      final match = createTestMatch();

      await repository.saveMatch(match);

      final box = HiveBoxes.getMatchesBox();
      expect(box.length, equals(1));
      expect(box.containsKey('match1'), isTrue);
    });

    test('getMatchById should retrieve a saved match', () async {
      final match = createTestMatch(id: 'match1');

      await repository.saveMatch(match);
      final retrieved = await repository.getMatchById('match1');

      expect(retrieved, isNotNull);
      expect(retrieved!.id, equals('match1'));
      expect(retrieved.matchType, equals(MatchType.friendly));
      expect(retrieved.playingSide, equals(PlayingSide.right));
      expect(retrieved.partner.name, equals('Partner'));
      expect(retrieved.opponent1.name, equals('Opponent 1'));
      expect(retrieved.opponent2.name, equals('Opponent 2'));
      expect(retrieved.result.sets.length, equals(2));
      expect(retrieved.result.sets[0].userTeamGames, equals(6));
      expect(retrieved.result.sets[0].opponentTeamGames, equals(4));
    });

    test('getMatchById should return null for non-existing match', () async {
      final retrieved = await repository.getMatchById('non_existing');

      expect(retrieved, isNull);
    });

    test('saveMatch should update existing match', () async {
      final match1 = createTestMatch(
        id: 'match1',
        performanceRating: 3,
        notes: 'First version',
      );

      await repository.saveMatch(match1);

      final match2 = createTestMatch(
        id: 'match1',
        performanceRating: 5,
        notes: 'Updated version',
      );

      await repository.saveMatch(match2);

      final retrieved = await repository.getMatchById('match1');
      expect(retrieved, isNotNull);
      expect(retrieved!.performanceRating, equals(5));
      expect(retrieved.notes, equals('Updated version'));

      final box = HiveBoxes.getMatchesBox();
      expect(box.length, equals(1));
    });

    test('getAllMatches should return empty list when no matches', () async {
      final matches = await repository.getAllMatches();

      expect(matches, isEmpty);
    });

    test('getAllMatches should return all saved matches', () async {
      final match1 = createTestMatch(id: 'match1');
      final match2 = createTestMatch(id: 'match2');
      final match3 = createTestMatch(id: 'match3');

      await repository.saveMatch(match1);
      await repository.saveMatch(match2);
      await repository.saveMatch(match3);

      final matches = await repository.getAllMatches();

      expect(matches.length, equals(3));
      expect(
        matches.map((m) => m.id),
        containsAll(['match1', 'match2', 'match3']),
      );
    });

    test(
      'getAllMatches should return matches sorted by date (newest first)',
      () async {
        final match1 = createTestMatch(
          id: 'match1',
          dateTime: DateTime(2025, 1, 10),
        );
        final match2 = createTestMatch(
          id: 'match2',
          dateTime: DateTime(2025, 1, 15),
        );
        final match3 = createTestMatch(
          id: 'match3',
          dateTime: DateTime(2025, 1, 5),
        );

        await repository.saveMatch(match1);
        await repository.saveMatch(match2);
        await repository.saveMatch(match3);

        final matches = await repository.getAllMatches();

        expect(matches.length, equals(3));
        expect(matches[0].id, equals('match2')); // Jan 15 (newest)
        expect(matches[1].id, equals('match1')); // Jan 10
        expect(matches[2].id, equals('match3')); // Jan 5 (oldest)
      },
    );

    test('deleteMatch should remove a match', () async {
      final match = createTestMatch(id: 'match1');

      await repository.saveMatch(match);
      expect((await repository.getAllMatches()).length, equals(1));

      await repository.deleteMatch('match1');

      expect((await repository.getAllMatches()).length, equals(0));
      expect(await repository.getMatchById('match1'), isNull);
    });

    test('deleteMatch should do nothing if match does not exist', () async {
      final match = createTestMatch(id: 'match1');
      await repository.saveMatch(match);

      await repository.deleteMatch('non_existing');

      expect((await repository.getAllMatches()).length, equals(1));
    });

    test('clearAll should remove all matches', () async {
      final match1 = createTestMatch(id: 'match1');
      final match2 = createTestMatch(id: 'match2');
      final match3 = createTestMatch(id: 'match3');

      await repository.saveMatch(match1);
      await repository.saveMatch(match2);
      await repository.saveMatch(match3);

      expect((await repository.getAllMatches()).length, equals(3));

      await repository.clearAll();

      expect((await repository.getAllMatches()).length, equals(0));
      final box = HiveBoxes.getMatchesBox();
      expect(box.isEmpty, isTrue);
    });

    test('should handle match with all optional fields', () async {
      final match = createTestMatch(
        id: 'match1',
        performanceRating: 4,
        notes: 'Great match with friends!',
      );

      await repository.saveMatch(match);
      final retrieved = await repository.getMatchById('match1');

      expect(retrieved, isNotNull);
      expect(retrieved!.performanceRating, equals(4));
      expect(retrieved.notes, equals('Great match with friends!'));
    });

    test('should handle match without optional fields', () async {
      final match = createTestMatch(id: 'match1');

      await repository.saveMatch(match);
      final retrieved = await repository.getMatchById('match1');

      expect(retrieved, isNotNull);
      expect(retrieved!.performanceRating, isNull);
      expect(retrieved.notes, isNull);
    });

    test('should handle different match types', () async {
      final friendlyMatch = createTestMatch(
        id: 'match1',
        matchType: MatchType.friendly,
      );
      final leagueMatch = createTestMatch(
        id: 'match2',
        matchType: MatchType.league,
      );
      final tournamentMatch = createTestMatch(
        id: 'match3',
        matchType: MatchType.tournament,
      );

      await repository.saveMatch(friendlyMatch);
      await repository.saveMatch(leagueMatch);
      await repository.saveMatch(tournamentMatch);

      final retrieved1 = await repository.getMatchById('match1');
      final retrieved2 = await repository.getMatchById('match2');
      final retrieved3 = await repository.getMatchById('match3');

      expect(retrieved1!.matchType, equals(MatchType.friendly));
      expect(retrieved2!.matchType, equals(MatchType.league));
      expect(retrieved3!.matchType, equals(MatchType.tournament));
    });

    test('should handle different playing sides', () async {
      final rightSideMatch = createTestMatch(
        id: 'match1',
        playingSide: PlayingSide.right,
      );
      final leftSideMatch = createTestMatch(
        id: 'match2',
        playingSide: PlayingSide.left,
      );

      await repository.saveMatch(rightSideMatch);
      await repository.saveMatch(leftSideMatch);

      final retrieved1 = await repository.getMatchById('match1');
      final retrieved2 = await repository.getMatchById('match2');

      expect(retrieved1!.playingSide, equals(PlayingSide.right));
      expect(retrieved2!.playingSide, equals(PlayingSide.left));
    });

    test('should preserve player information', () async {
      final match = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: DateTime(2025, 1, 15),
        playingSide: PlayingSide.right,
        partner: const Player(id: 'p1', name: 'John Doe', nickname: 'Johnny'),
        opponent1: const Player(id: 'o1', name: 'Jane Smith'),
        opponent2: const Player(
          id: 'o2',
          name: 'Bob Wilson',
          nickname: 'Bobby',
        ),
        result: const MatchResult(
          sets: [PadelSet(userTeamGames: 6, opponentTeamGames: 4)],
        ),
      );

      await repository.saveMatch(match);
      final retrieved = await repository.getMatchById('match1');

      expect(retrieved, isNotNull);
      expect(retrieved!.partner.id, equals('p1'));
      expect(retrieved.partner.name, equals('John Doe'));
      expect(retrieved.partner.nickname, equals('Johnny'));
      expect(retrieved.opponent1.id, equals('o1'));
      expect(retrieved.opponent1.name, equals('Jane Smith'));
      expect(retrieved.opponent1.nickname, isNull);
      expect(retrieved.opponent2.id, equals('o2'));
      expect(retrieved.opponent2.name, equals('Bob Wilson'));
      expect(retrieved.opponent2.nickname, equals('Bobby'));
    });

    test('should preserve match result with multiple sets', () async {
      final match = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: DateTime(2025, 1, 15),
        playingSide: PlayingSide.right,
        partner: const Player(id: 'p1', name: 'Partner'),
        opponent1: const Player(id: 'o1', name: 'Opponent 1'),
        opponent2: const Player(id: 'o2', name: 'Opponent 2'),
        result: const MatchResult(
          sets: [
            PadelSet(userTeamGames: 6, opponentTeamGames: 4),
            PadelSet(userTeamGames: 3, opponentTeamGames: 6),
            PadelSet(userTeamGames: 7, opponentTeamGames: 5),
          ],
        ),
      );

      await repository.saveMatch(match);
      final retrieved = await repository.getMatchById('match1');

      expect(retrieved, isNotNull);
      expect(retrieved!.result.sets.length, equals(3));
      expect(retrieved.result.sets[0].userTeamGames, equals(6));
      expect(retrieved.result.sets[0].opponentTeamGames, equals(4));
      expect(retrieved.result.sets[1].userTeamGames, equals(3));
      expect(retrieved.result.sets[1].opponentTeamGames, equals(6));
      expect(retrieved.result.sets[2].userTeamGames, equals(7));
      expect(retrieved.result.sets[2].opponentTeamGames, equals(5));
    });

    test('should handle concurrent operations', () async {
      final matches = List.generate(
        10,
        (i) =>
            createTestMatch(id: 'match$i', dateTime: DateTime(2025, 1, i + 1)),
      );

      // Save all matches concurrently
      await Future.wait(matches.map((m) => repository.saveMatch(m)));

      final retrieved = await repository.getAllMatches();
      expect(retrieved.length, equals(10));
    });

    test('data should persist across repository instances', () async {
      final match = createTestMatch(id: 'match1');
      await repository.saveMatch(match);

      // Create a new repository instance
      final newRepository = MatchRepositoryHive();
      final retrieved = await newRepository.getMatchById('match1');

      expect(retrieved, isNotNull);
      expect(retrieved!.id, equals('match1'));
    });
  });
}
