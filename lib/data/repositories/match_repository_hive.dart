import 'package:padel_tracker/data/hive/hive_boxes.dart';
import 'package:padel_tracker/data/models/match_entity.dart';
import 'package:padel_tracker/domain/models/match.dart';
import 'package:padel_tracker/domain/repositories/match_repository.dart';

/// Hive-based implementation of [MatchRepository]
///
/// This implementation uses Hive for local persistence and handles
/// the conversion between domain models and Hive entities.
class MatchRepositoryHive implements MatchRepository {
  @override
  Future<List<Match>> getAllMatches() async {
    final box = HiveBoxes.getMatchesBox();

    final matches = box.values.map((entity) => entity.toDomain()).toList();

    // Sort by date, newest first
    matches.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return matches;
  }

  @override
  Future<Match?> getMatchById(String id) async {
    final box = HiveBoxes.getMatchesBox();
    final entity = box.get(id);

    return entity?.toDomain();
  }

  @override
  Future<void> saveMatch(Match match) async {
    final box = HiveBoxes.getMatchesBox();
    final entity = MatchEntity.fromDomain(match);

    await box.put(match.id, entity);
  }

  @override
  Future<void> deleteMatch(String matchId) async {
    final box = HiveBoxes.getMatchesBox();
    await box.delete(matchId);
  }

  @override
  Future<void> clearAll() async {
    final box = HiveBoxes.getMatchesBox();
    await box.clear();
  }
}
