import 'package:hive/hive.dart';
import 'package:padel_tracker/data/models/match_result_entity.dart';
import 'package:padel_tracker/data/models/player_entity.dart';
import 'package:padel_tracker/domain/enums/match_type.dart';
import 'package:padel_tracker/domain/enums/playing_side.dart';
import 'package:padel_tracker/domain/models/match.dart';

part 'match_entity.g.dart';

/// Hive entity for Match
/// Handles persistence of match data
@HiveType(typeId: 3)
class MatchEntity extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int matchTypeIndex;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final int playingSideIndex;

  @HiveField(4)
  final PlayerEntity partner;

  @HiveField(5)
  final PlayerEntity opponent1;

  @HiveField(6)
  final PlayerEntity opponent2;

  @HiveField(7)
  final MatchResultEntity result;

  @HiveField(8)
  final int? performanceRating;

  @HiveField(9)
  final String? notes;

  @HiveField(10)
  final int? durationInMinutes;

  @HiveField(11)
  final String? location;

  MatchEntity({
    required this.id,
    required this.matchTypeIndex,
    required this.dateTime,
    required this.playingSideIndex,
    required this.partner,
    required this.opponent1,
    required this.opponent2,
    required this.result,
    this.performanceRating,
    this.notes,
    this.durationInMinutes,
    this.location,
  });

  /// Converts domain Match to MatchEntity
  factory MatchEntity.fromDomain(Match match) {
    return MatchEntity(
      id: match.id,
      matchTypeIndex: match.matchType.index,
      dateTime: match.dateTime,
      playingSideIndex: match.playingSide.index,
      partner: PlayerEntity.fromDomain(match.partner),
      opponent1: PlayerEntity.fromDomain(match.opponent1),
      opponent2: PlayerEntity.fromDomain(match.opponent2),
      result: MatchResultEntity.fromDomain(match.result),
      performanceRating: match.performanceRating,
      notes: match.notes,
      durationInMinutes: match.duration?.inMinutes,
      location: match.location,
    );
  }

  /// Converts MatchEntity to domain Match
  Match toDomain() {
    return Match(
      id: id,
      matchType: MatchType.values[matchTypeIndex],
      dateTime: dateTime,
      playingSide: PlayingSide.values[playingSideIndex],
      partner: partner.toDomain(),
      opponent1: opponent1.toDomain(),
      opponent2: opponent2.toDomain(),
      result: result.toDomain(),
      performanceRating: performanceRating,
      notes: notes,
      duration: durationInMinutes != null
          ? Duration(minutes: durationInMinutes!)
          : null,
      location: location,
    );
  }
}
