import 'package:hive_flutter/hive_flutter.dart';
import 'package:padel_tracker/data/hive/hive_boxes.dart';
import 'package:padel_tracker/data/models/match_entity.dart';
import 'package:padel_tracker/data/models/match_result_entity.dart';
import 'package:padel_tracker/data/models/padel_set_entity.dart';
import 'package:padel_tracker/data/models/player_entity.dart';

/// IMPORTANT:
/// Hive typeIds must NEVER be changed once released.
/// New entities must use new incremental IDs.

/// Hive initialization
/// Initializes Hive and registers all type adapters
class HiveInitializer {
  /// Initializes Hive for Flutter
  /// Must be called before using any Hive functionality
  static Future<void> initialize() async {
    // Initialize Hive for Flutter
    await Hive.initFlutter();

    // Register all type adapters
    _registerAdapters();

    // Open all boxes
    await HiveBoxes.openBoxes();
  }

  /// Registers all Hive type adapters
  static void _registerAdapters() {
    // Register PlayerEntity adapter (typeId: 0)
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(PlayerEntityAdapter());
    }

    // Register PadelSetEntity adapter (typeId: 1)
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(PadelSetEntityAdapter());
    }

    // Register MatchResultEntity adapter (typeId: 2)
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(MatchResultEntityAdapter());
    }

    // Register MatchEntity adapter (typeId: 3)
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(MatchEntityAdapter());
    }
  }
}
