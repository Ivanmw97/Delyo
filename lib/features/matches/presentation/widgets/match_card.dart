import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:delyo/presentation/theme/app_colors.dart';
import 'package:delyo/domain/models/match.dart';
import 'package:delyo/domain/enums/match_type.dart';
import 'package:delyo/features/matches/presentation/models/match_outcome.dart';
import 'package:delyo/features/matches/presentation/utils/match_outcome_helper.dart';
import 'package:delyo/l10n/app_localizations.dart';

class MatchCard extends StatelessWidget {
  final Match match;
  final VoidCallback onTap;

  const MatchCard({super.key, required this.match, required this.onTap});

  String _getMatchTypeName(MatchType type, BuildContext context) {
    switch (type) {
      case MatchType.friendly:
        return AppLocalizations.of(context)!.matchTypeFriendlyDisplay;
      case MatchType.league:
        return AppLocalizations.of(context)!.matchTypeLeagueDisplay;
      case MatchType.tournament:
        return AppLocalizations.of(context)!.matchTypeTournamentDisplay;
    }
  }

  Color _getResultColor(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return AppColors.win;
      case MatchOutcome.loss:
        return AppColors.loss;
      case MatchOutcome.draw:
        return AppColors.draw;
    }
  }

  Color _getResultBackgroundColor(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return AppColors.win;
      case MatchOutcome.loss:
        return AppColors.loss;
      case MatchOutcome.draw:
        return AppColors.draw;
    }
  }

  Color _getMatchTypeColor(MatchType matchType) {
    switch (matchType) {
      case MatchType.friendly:
        return AppColors.accent;
      case MatchType.league:
        return AppColors.orange;
      case MatchType.tournament:
        return const Color(0xFF5856D6);
    }
  }

  Color _getMatchTypeBackgroundColor(MatchType matchType) {
    switch (matchType) {
      case MatchType.friendly:
        return AppColors.accent.withValues(alpha: 0.12);
      case MatchType.league:
        return AppColors.orange.withValues(alpha: 0.12);
      case MatchType.tournament:
        return const Color(0xFF5856D6).withValues(alpha: 0.12);
    }
  }

  String _getOutcomeText(MatchOutcome outcome, BuildContext context) {
    switch (outcome) {
      case MatchOutcome.win:
        return AppLocalizations.of(context)!.win;
      case MatchOutcome.loss:
        return AppLocalizations.of(context)!.loss;
      case MatchOutcome.draw:
        return AppLocalizations.of(context)!.draw;
    }
  }

  String _getScoreText(BuildContext context) {
    final sets = match.result.sets;
    if (sets.isEmpty) return AppLocalizations.of(context)!.noScore;

    return sets
        .map((set) => '${set.userTeamGames}-${set.opponentTeamGames}')
        .join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final outcome = getMatchOutcome(match);
    final locale = Localizations.localeOf(context);
    final dateFormat = DateFormat.yMMMd(locale.toString());

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Stack(
          children: [
            // Colored vertical accent bar
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 4,
                decoration: BoxDecoration(
                  color: _getResultBackgroundColor(outcome),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row with match type, result badge, and date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Match Type
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: _getMatchTypeBackgroundColor(
                                match.matchType,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _getMatchTypeName(
                                match.matchType,
                                context,
                              ).toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getMatchTypeColor(match.matchType),
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Result Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: _getResultBackgroundColor(
                                outcome,
                              ).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _getOutcomeText(outcome, context).toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: _getResultColor(outcome),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Date
                      Text(
                        dateFormat.format(match.dateTime),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                          letterSpacing: -0.1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Main content: Set scores (primary focus)
                  Text(
                    _getScoreText(context),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onSurface,
                      letterSpacing: -0.8,
                      height: 1.1,
                    ),
                  ),

                  // Location (only if available)
                  if (match.location != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.4),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            match.location!,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.6),
                              letterSpacing: -0.1,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
