import 'package:flutter/material.dart';
import 'package:delyo/features/matches/presentation/models/match_outcome.dart';
import 'package:delyo/l10n/app_localizations.dart';

class PerformanceBlockWidget extends StatelessWidget {
  final int totalMatches;
  final int wins;
  final int losses;
  final int draws;
  final List<dynamic> matches;
  final String Function(int, int, int) getPerformanceMessage;
  final List<MatchOutcome> Function(List<dynamic>, {int limit})
  getRecentOutcomes;

  const PerformanceBlockWidget({
    super.key,
    required this.totalMatches,
    required this.wins,
    required this.losses,
    required this.draws,
    required this.matches,
    required this.getPerformanceMessage,
    required this.getRecentOutcomes,
  });

  @override
  Widget build(BuildContext context) {
    final performanceMessage = getPerformanceMessage(wins, losses, draws);
    final decidedMatches = wins + losses;
    final winRateExcludingDraws = decidedMatches > 0
        ? ((wins / decidedMatches) * 100).round()
        : 0;

    String supportingLine = '';
    if (totalMatches == 0) {
      supportingLine = AppLocalizations.of(context)!.yourPadelJourneyBeginsHere;
    } else if (totalMatches == 1) {
      supportingLine = AppLocalizations.of(context)!.oneMatchPlayed;
    } else {
      final parts = <String>[];
      if (wins > 0) {
        parts.add(
          '$wins ${wins == 1 ? AppLocalizations.of(context)!.victory : AppLocalizations.of(context)!.victories}',
        );
      }
      if (losses > 0) {
        parts.add(
          '$losses ${losses == 1 ? AppLocalizations.of(context)!.defeat : AppLocalizations.of(context)!.defeats}',
        );
      }
      if (draws > 0) {
        parts.add(
          '$draws ${draws == 1 ? AppLocalizations.of(context)!.draw : AppLocalizations.of(context)!.draws}',
        );
      }

      supportingLine = AppLocalizations.of(
        context,
      )!.lastMatchesWithResults(totalMatches, parts.join(', '));
    }

    final recentOutcomes = getRecentOutcomes(matches);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D1D1F).withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            performanceMessage,
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1D1D1F),
              letterSpacing: -1.0,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            totalMatches > 1
                ? AppLocalizations.of(context)!.recentPerformance
                : '',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1D1D1F).withValues(alpha: 0.4),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            supportingLine,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF1D1D1F).withValues(alpha: 0.6),
              letterSpacing: -0.2,
              height: 1.3,
            ),
          ),
          if (recentOutcomes.isNotEmpty && totalMatches > 1) ...[
            const SizedBox(height: 20),
            Row(
              children: recentOutcomes.map((outcome) {
                Color letterColor;
                String letter;
                switch (outcome) {
                  case MatchOutcome.win:
                    letterColor = const Color(0xFF34C759);
                    letter = AppLocalizations.of(context)!.winLetter;
                    break;
                  case MatchOutcome.loss:
                    letterColor = const Color(0xFFFF3B30);
                    letter = AppLocalizations.of(context)!.lossLetter;
                    break;
                  case MatchOutcome.draw:
                    letterColor = const Color(0xFF8E8E93);
                    letter = AppLocalizations.of(context)!.drawLetter;
                    break;
                }

                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: letterColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: letterColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          if (decidedMatches > 0) ...[
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(
                context,
              )!.winRateExcludingDraws(winRateExcludingDraws),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF1D1D1F).withValues(alpha: 0.3),
                letterSpacing: -0.08,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
