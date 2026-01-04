import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padel_tracker/data/repositories/match_repository_hive.dart';
import 'package:padel_tracker/domain/repositories/match_repository.dart';

/// Provider for MatchRepository
///
/// This is the single access point to the repository throughout the app.
/// It provides a Hive-based implementation of the MatchRepository contract.
final matchRepositoryProvider = Provider<MatchRepository>((ref) {
  return MatchRepositoryHive();
});
