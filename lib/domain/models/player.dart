/// Player entity
/// Represents a player (user, partner, or opponent)
/// Contains player identification and basic information
class Player {
  /// Unique identifier for the player
  final String id;

  /// Player's name
  final String name;

  /// Optional player nickname
  final String? nickname;

  /// Creates a new [Player] instance
  const Player({required this.id, required this.name, this.nickname});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Player &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          nickname == other.nickname;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ nickname.hashCode;

  @override
  String toString() => 'Player(id: $id, name: $name, nickname: $nickname)';
}
