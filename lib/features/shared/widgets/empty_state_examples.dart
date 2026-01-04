import 'package:flutter/material.dart';
import 'package:padel_tracker/features/shared/widgets/empty_state.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';

/// Example implementations of EmptyState for different screens
/// These demonstrate the three main empty state patterns in the app

class EmptyStateExamples {
  /// 1️⃣ Home – First-time user (no matches at all)
  /// Purpose: Onboard user and encourage first action
  static Widget homeFirstTime(
    BuildContext context, {
    required VoidCallback onAddMatch,
  }) {
    return EmptyState(
      icon: Icons.sports_tennis_outlined,
      title: AppLocalizations.of(context)!.startTrackingMatches,
      subtitle: AppLocalizations.of(context)!.addFirstMatchSubtitle,
      primaryActionText: AppLocalizations.of(context)!.addMatch,
      onPrimaryAction: onAddMatch,
    );
  }

  /// 1️⃣ Home – Filtered empty (matches exist, but not in range)
  /// Purpose: Explain empty list and suggest filter adjustment
  static Widget homeFiltered(BuildContext context) {
    return EmptyState(
      icon: Icons.calendar_today_outlined,
      title: AppLocalizations.of(context)!.noMatchesInPeriod,
      subtitle: AppLocalizations.of(context)!.tryChangingTimeRange,
    );
  }

  /// 2️⃣ My Matches – First-time user (no matches at all)
  /// Purpose: Most action-driven empty state - encourage first match creation
  static Widget myMatchesFirstTime(
    BuildContext context, {
    required VoidCallback onAddMatch,
  }) {
    return EmptyState(
      icon: Icons.sports_tennis_outlined,
      title: AppLocalizations.of(context)!.noMatchesAddedYet,
      subtitle: AppLocalizations.of(context)!.startByAddingFirstMatch,
      primaryActionText: AppLocalizations.of(context)!.addMatch,
      onPrimaryAction: onAddMatch,
    );
  }

  /// 2️⃣ My Matches – Filtered empty (matches exist, but not in range)
  /// Purpose: Explain empty list and suggest filter adjustment
  static Widget myMatchesFiltered(BuildContext context) {
    return EmptyState(
      icon: Icons.calendar_today_outlined,
      title: AppLocalizations.of(context)!.noMatchesInPeriod,
      subtitle: AppLocalizations.of(context)!.tryChangingTimeRange,
    );
  }

  /// 3️⃣ Stats – First-time user (no matches at all)
  /// Purpose: Explain why stats are empty and redirect to core action
  static Widget statsFirstTime(
    BuildContext context, {
    VoidCallback? onAddMatch,
  }) {
    return EmptyState(
      icon: Icons.analytics_outlined,
      title: AppLocalizations.of(context)!.noStatsYet,
      subtitle: AppLocalizations.of(context)!.addMatchesToSeeStats,
      primaryActionText: onAddMatch != null
          ? AppLocalizations.of(context)!.addMatch
          : null,
      onPrimaryAction: onAddMatch,
    );
  }

  /// 3️⃣ Stats – Filtered empty (matches exist, but not in range)
  /// Purpose: Explain stats unavailable for period, suggest changing range
  static Widget statsFiltered(BuildContext context) {
    return EmptyState(
      icon: Icons.analytics_outlined,
      title: AppLocalizations.of(context)!.noDataForThisPeriod,
      subtitle: AppLocalizations.of(context)!.changeRangeToSeeOtherStats,
    );
  }
}
