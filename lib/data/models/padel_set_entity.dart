import 'package:hive/hive.dart';
import 'package:padel_tracker/domain/models/padel_set.dart';

part 'padel_set_entity.g.dart';

/// Hive entity for PadelSet
/// Handles persistence of set data
@HiveType(typeId: 1)
class PadelSetEntity extends HiveObject {
  @HiveField(0)
  final int userTeamGames;

  @HiveField(1)
  final int opponentTeamGames;

  PadelSetEntity({
    required this.userTeamGames,
    required this.opponentTeamGames,
  });

  /// Converts domain PadelSet to PadelSetEntity
  factory PadelSetEntity.fromDomain(PadelSet set) {
    return PadelSetEntity(
      userTeamGames: set.userTeamGames,
      opponentTeamGames: set.opponentTeamGames,
    );
  }

  /// Converts PadelSetEntity to domain PadelSet
  PadelSet toDomain() {
    return PadelSet(
      userTeamGames: userTeamGames,
      opponentTeamGames: opponentTeamGames,
    );
  }
}
