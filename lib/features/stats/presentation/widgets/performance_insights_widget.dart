import 'package:flutter/material.dart';
import 'package:padel_tracker/features/matches/presentation/models/match_outcome.dart';
import 'package:padel_tracker/features/matches/presentation/utils/match_outcome_helper.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';

class PerformanceInsightsWidget extends StatelessWidget {
  final List matches;

  const PerformanceInsightsWidget({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    final avgRating = matches.isNotEmpty
        ? matches.map((m) => m.performanceRating ?? 3).reduce((a, b) => a + b) /
              matches.length
        : 0.0;

    final recentMatches = matches.length >= 5
        ? matches.take(5).toList()
        : matches;

    final recentWins = recentMatches
        .where((m) => getMatchOutcome(m) == MatchOutcome.win)
        .length;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D1D1F).withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.performanceInsights,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1D1D1F).withValues(alpha: 0.4),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildInsightCard(
                  AppLocalizations.of(context)!.avgRating,
                  avgRating.toStringAsFixed(1),
                  AppLocalizations.of(context)!.howYouRatePerformance,
                  Icons.star,
                  const Color(0xFFFF9500),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInsightCard(
                  AppLocalizations.of(context)!.recentForm,
                  '$recentWins/${recentMatches.length}',
                  AppLocalizations.of(
                    context,
                  )!.winsInLastMatches(recentMatches.length),
                  Icons.trending_up,
                  const Color(0xFF34C759),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(
    String label,
    String value,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1D1D1F).withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1D1D1F),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF1D1D1F).withValues(alpha: 0.5),
              letterSpacing: -0.1,
            ),
          ),
        ],
      ),
    );
  }
}
