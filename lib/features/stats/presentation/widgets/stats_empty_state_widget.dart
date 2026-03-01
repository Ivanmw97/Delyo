import 'package:flutter/material.dart';
import 'package:delyo/l10n/app_localizations.dart';

class StatsEmptyStateWidget extends StatelessWidget {
  const StatsEmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.analytics_outlined,
            size: 64,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.noMatchesYet,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.addMatchesToSeeStats,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
