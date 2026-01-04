import 'package:hive/hive.dart';
import 'package:padel_tracker/domain/models/player.dart';

part 'player_entity.g.dart';

/// Hive entity for Player
/// Handles persistence of player data
@HiveType(typeId: 0)
class PlayerEntity extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? nickname;

  PlayerEntity({required this.id, required this.name, this.nickname});

  /// Converts domain Player to PlayerEntity
  factory PlayerEntity.fromDomain(Player player) {
    return PlayerEntity(
      id: player.id,
      name: player.name,
      nickname: player.nickname,
    );
  }

  /// Converts PlayerEntity to domain Player
  Player toDomain() {
    return Player(id: id, name: name, nickname: nickname);
  }
}
