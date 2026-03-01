import 'package:flutter/material.dart';
import 'package:delyo/presentation/theme/app_colors.dart';
import 'package:delyo/domain/enums/match_type.dart';
import 'package:delyo/l10n/app_localizations.dart';

class MatchTypesBreakdownWidget extends StatelessWidget {
  final List matches;

  const MatchTypesBreakdownWidget({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    final friendly = matches
        .where((m) => m.matchType == MatchType.friendly)
        .length;
    final league = matches.where((m) => m.matchType == MatchType.league).length;
    final tournament = matches
        .where((m) => m.matchType == MatchType.tournament)
        .length;
    final total = matches.length;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.matchTypesBreakdown,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),

          _buildMatchTypeBar(
            context,
            AppLocalizations.of(context)!.friendly,
            friendly,
            total,
            AppColors.accent,
          ),
          const SizedBox(height: 12),
          _buildMatchTypeBar(
            context,
            AppLocalizations.of(context)!.league,
            league,
            total,
            AppColors.orange,
          ),
          const SizedBox(height: 12),
          _buildMatchTypeBar(
            context,
            AppLocalizations.of(context)!.tournament,
            tournament,
            total,
            const Color(
              0xFF5856D6,
            ), // tournament purple — no AppColors equivalent
          ),
        ],
      ),
    );
  }

  Widget _buildMatchTypeBar(
    BuildContext context,
    String label,
    int count,
    int total,
    Color color,
  ) {
    final percentage = total > 0 ? count / total : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
