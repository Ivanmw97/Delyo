import 'package:hive_flutter/hive_flutter.dart';
import 'package:padel_tracker/data/models/match_entity.dart';

/// Centralized Hive box management
/// Provides access to all Hive boxes used in the application
class HiveBoxes {
  /// Box name for matches
  static const String matchesBox = 'matches';

  /// Opens all required Hive boxes
  static Future<void> openBoxes() async {
    await Hive.openBox<MatchEntity>(matchesBox);
  }

  /// Gets the matches box
  static Box<MatchEntity> getMatchesBox() {
    return Hive.box<MatchEntity>(matchesBox);
  }

  /// Closes all Hive boxes
  static Future<void> closeBoxes() async {
    await Hive.close();
  }
}
