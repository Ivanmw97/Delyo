import 'package:flutter/material.dart';
import 'package:delyo/presentation/theme/app_colors.dart';
import 'package:delyo/features/matches/presentation/models/match_outcome.dart';
import 'package:delyo/features/matches/presentation/utils/match_outcome_helper.dart';
import 'package:delyo/features/stats/presentation/widgets/donut_chart_painter.dart';
import 'package:delyo/l10n/app_localizations.dart';

class ResultsDistributionWidget extends StatelessWidget {
  final List matches;

  const ResultsDistributionWidget({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    final outcomes = matches.map((match) => getMatchOutcome(match)).toList();
    final wins = outcomes.where((o) => o == MatchOutcome.win).length;
    final losses = outcomes.where((o) => o == MatchOutcome.loss).length;
    final draws = outcomes.where((o) => o == MatchOutcome.draw).length;
    final total = matches.length;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.resultsDistribution,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),

          // Donut Chart
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: CustomPaint(
                painter: DonutChartPainter(
                  wins: wins,
                  losses: losses,
                  draws: draws,
                  total: total,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLegendItem(
                context,
                AppLocalizations.of(context)!.wins,
                wins,
                total,
                AppColors.win,
              ),
              _buildLegendItem(
                context,
                AppLocalizations.of(context)!.losses,
                losses,
                total,
                AppColors.loss,
              ),
              _buildLegendItem(
                context,
                AppLocalizations.of(context)!.draws,
                draws,
                total,
                AppColors.draw,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(
    BuildContext context,
    String label,
    int count,
    int total,
    Color color,
  ) {
    final percentage = total > 0 ? (count / total * 100).round() : 0;

    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(
          '$percentage%',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }
}
