import 'package:hive/hive.dart';
import 'package:padel_tracker/data/models/padel_set_entity.dart';
import 'package:padel_tracker/domain/models/match_result.dart';

part 'match_result_entity.g.dart';

/// Hive entity for MatchResult
/// Handles persistence of match result data
@HiveType(typeId: 2)
class MatchResultEntity extends HiveObject {
  @HiveField(0)
  final List<PadelSetEntity> sets;

  MatchResultEntity({required this.sets});

  /// Converts domain MatchResult to MatchResultEntity
  factory MatchResultEntity.fromDomain(MatchResult result) {
    return MatchResultEntity(
      sets: result.sets.map((set) => PadelSetEntity.fromDomain(set)).toList(),
    );
  }

  /// Converts MatchResultEntity to domain MatchResult
  MatchResult toDomain() {
    return MatchResult(sets: sets.map((set) => set.toDomain()).toList());
  }
}
