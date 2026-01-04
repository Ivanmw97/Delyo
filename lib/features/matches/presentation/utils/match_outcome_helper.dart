import 'package:flutter/widgets.dart';
import 'package:padel_tracker/domain/enums/match_type.dart';
import 'package:padel_tracker/domain/models/match.dart';
import 'package:padel_tracker/features/matches/presentation/models/match_outcome.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';

/// Helper function to determine the outcome of a match for UI display
///
/// Rules:
/// - Friendly matches: can be win, loss, or draw
/// - Official matches (league/tournament): always have a winner (win or loss)
MatchOutcome getMatchOutcome(Match match) {
  final setsWon = match.result.setsWon;
  final setsLost = match.result.setsLost;

  if (match.matchType == MatchType.friendly) {
    // Friendly matches can end in a draw
    if (setsWon == setsLost) {
      return MatchOutcome.draw;
    } else if (setsWon > setsLost) {
      return MatchOutcome.win;
    } else {
      return MatchOutcome.loss;
    }
  } else {
    // Official matches (league/tournament) always have a winner
    return match.result.isMatchWon ? MatchOutcome.win : MatchOutcome.loss;
  }
}

String getMatchResultText(Match match, BuildContext context) {
  final outcome = getMatchOutcome(match);
  final setsWon = match.result.setsWon;
  final setsLost = match.result.setsLost;

  if (outcome == MatchOutcome.draw) {
    return AppLocalizations.of(context)!.drawResult(setsWon, setsLost);
  } else if (outcome == MatchOutcome.win) {
    return AppLocalizations.of(context)!.winResult(setsWon, setsLost);
  } else {
    return AppLocalizations.of(context)!.lossResult(setsWon, setsLost);
  }
}
