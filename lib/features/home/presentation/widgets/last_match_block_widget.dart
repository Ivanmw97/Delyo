import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:delyo/presentation/theme/app_colors.dart';
import 'package:delyo/features/matches/presentation/models/match_outcome.dart';
import 'package:delyo/features/matches/presentation/utils/match_outcome_helper.dart';
import 'package:delyo/features/matches/presentation/pages/match_detail_page.dart';
import 'package:delyo/domain/enums/match_type.dart';
import 'package:delyo/l10n/app_localizations.dart';

class LastMatchBlockWidget extends StatelessWidget {
  final dynamic match;
  final Widget Function(dynamic) buildSetScores;

  const LastMatchBlockWidget({
    super.key,
    required this.match,
    required this.buildSetScores,
  });

  @override
  Widget build(BuildContext context) {
    final outcome = getMatchOutcome(match);
    final dateFormat = DateFormat.yMMMd(
      Localizations.localeOf(context).languageCode,
    );

    String matchTypeName = '';
    switch (match.matchType) {
      case MatchType.friendly:
        matchTypeName = AppLocalizations.of(context)!.friendly;
        break;
      case MatchType.league:
        matchTypeName = AppLocalizations.of(context)!.league;
        break;
      case MatchType.tournament:
        matchTypeName = AppLocalizations.of(context)!.tournament;
        break;
    }

    String outcomeText = '';
    Color outcomeColor = Colors.grey;
    switch (outcome) {
      case MatchOutcome.win:
        outcomeText = AppLocalizations.of(context)!.victory;
        outcomeColor = AppColors.win;
        break;
      case MatchOutcome.loss:
        outcomeText = AppLocalizations.of(context)!.defeat;
        outcomeColor = AppColors.loss;
        break;
      case MatchOutcome.draw:
        outcomeText = AppLocalizations.of(context)!.draw;
        outcomeColor = AppColors.draw;
        break;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MatchDetailPage(match: match),
          ),
        );
      },
      child: Container(
        width: double.infinity,
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
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.lastMatch,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.4),
                    letterSpacing: -0.08,
                  ),
                ),
                Text(
                  dateFormat.format(match.dateTime),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.4),
                    letterSpacing: -0.08,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Match type
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                matchTypeName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Result chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: outcomeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    outcome == MatchOutcome.win
                        ? Icons.emoji_events
                        : outcome == MatchOutcome.loss
                        ? Icons.close
                        : Icons.remove,
                    size: 18,
                    color: outcomeColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    outcomeText.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: outcomeColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Set scores (main focus)
            buildSetScores(match),
            const SizedBox(height: 12),

            // Subtitle
            Text(
              AppLocalizations.of(context)!.straightSets,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.4),
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
