import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Repository for managing onboarding state persistence
///
/// Handles storing and retrieving whether the user has seen the onboarding
/// using Hive for local storage.
class OnboardingRepository {
  static const String _boxName = 'onboarding';
  static const String _hasSeenOnboardingKey = 'hasSeenOnboarding';

  Box? _box;

  /// Initialize the Hive box for onboarding data
  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  /// Check if the user has seen the onboarding
  /// Returns false by default for first-time users
  bool hasSeenOnboarding() {
    return _box?.get(_hasSeenOnboardingKey, defaultValue: false) ?? false;
  }

  /// Mark onboarding as completed
  /// Called when user taps "Empezar" button
  Future<void> markOnboardingCompleted() async {
    await _box?.put(_hasSeenOnboardingKey, true);
  }

  /// Debug utility for development/testing only
  ///
  /// Resets the onboarding state by deleting the hasSeenOnboarding flag,
  /// allowing the onboarding flow to be shown again on next app start.
  ///
  /// **IMPORTANT**: This method only works in debug mode (kDebugMode = true).
  /// It has no effect in release builds for production safety.
  ///
  /// Usage: Call this method during development to re-test the onboarding flow
  /// without reinstalling the app.
  Future<void> resetOnboarding() async {
    if (kDebugMode) {
      await _box?.delete(_hasSeenOnboardingKey);
      debugPrint('🔄 [DEBUG] Onboarding reset - will show on next app restart');
    }
  }

  /// Close the Hive box
  Future<void> close() async {
    await _box?.close();
  }
}
