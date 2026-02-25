import 'package:flutter/material.dart';
import 'package:delyo/presentation/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delyo/features/matches/state/matches_provider.dart';
import 'package:delyo/features/shared/state/filtered_matches_provider.dart';
import 'package:delyo/features/shared/widgets/time_range_filter.dart';
import 'package:delyo/features/matches/presentation/models/match_outcome.dart';
import 'package:delyo/features/matches/presentation/utils/match_outcome_helper.dart';
import 'package:delyo/features/home/presentation/widgets/performance_block_widget.dart';
import 'package:delyo/features/home/presentation/widgets/last_match_block_widget.dart';
import 'package:delyo/features/home/presentation/widgets/duration_card_widget.dart';
import 'package:delyo/features/home/presentation/widgets/location_card_widget.dart';
import 'package:delyo/features/shared/widgets/empty_state_examples.dart';
import 'package:delyo/features/matches/presentation/pages/add_match_page.dart';
import 'package:delyo/l10n/app_localizations.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(matchesProvider.notifier).loadMatches());
  }

  String _getPerformanceMessage(int wins, int losses, int draws) {
    final totalMatches = wins + losses + draws;

    if (totalMatches == 0) return AppLocalizations.of(context)!.readyToStart;

    if (losses == 0 && wins > 0) {
      return totalMatches == 1
          ? AppLocalizations.of(context)!.perfectStart
          : AppLocalizations.of(context)!.undefeatedSoFar;
    }

    if (wins == 0 && losses > 0) {
      return totalMatches == 1
          ? AppLocalizations.of(context)!.firstMatchDone
          : AppLocalizations.of(context)!.stillFindingRhythm;
    }

    final winRate = wins / (wins + losses);

    if (winRate >= 0.7) {
      return AppLocalizations.of(context)!.strongPerformance;
    } else if (winRate <= 0.3) {
      return AppLocalizations.of(context)!.buildingExperience;
    } else if (winRate >= 0.45 && winRate <= 0.55) {
      return AppLocalizations.of(context)!.balancedPerformance;
    } else if (winRate > 0.55) {
      return AppLocalizations.of(context)!.goodMomentum;
    } else {
      return AppLocalizations.of(context)!.learningAndImproving;
    }
  }

  List<MatchOutcome> _getRecentOutcomes(
    List<dynamic> matches, {
    int limit = 5,
  }) {
    return matches.take(limit).map((match) => getMatchOutcome(match)).toList();
  }

  Widget _buildSetScores(dynamic match) {
    final sets = match.result.sets;

    if (sets.isEmpty) {
      return Text(
        '${match.result.setsWon}–${match.result.setsLost}',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w900,
          color: Theme.of(context).colorScheme.onSurface,
          letterSpacing: -1.5,
          height: 0.9,
        ),
      );
    }

    // Build RichText with smaller commas
    final List<TextSpan> spans = [];
    for (int i = 0; i < sets.length; i++) {
      final set = sets[i];
      spans.add(
        TextSpan(
          text: '${set.userTeamGames}-${set.opponentTeamGames}',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: -1.5,
            height: 0.9,
          ),
        ),
      );

      if (i < sets.length - 1) {
        spans.add(
          TextSpan(
            text: ', ',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: AppColors.draw.withValues(alpha: 0.8),
              letterSpacing: -0.8,
              height: 0.9,
            ),
          ),
        );
      }
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: spans),
    );
  }

  @override
  Widget build(BuildContext context) {
    final matchesState = ref.watch(matchesProvider);
    final filteredMatches = ref.watch(filteredMatchesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.homeTitle,
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        centerTitle: false,
      ),
      body: matchesState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : matchesState.matches.isEmpty
          ? _buildEmptyState()
          : filteredMatches.isEmpty
          ? _buildEmptyFilteredState()
          : _buildContent(filteredMatches),
    );
  }

  Widget _buildEmptyState() {
    // First-time user (no matches at all)
    return EmptyStateExamples.homeFirstTime(
      context,
      onAddMatch: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddMatchPage()),
        );
      },
    );
  }

  Widget _buildEmptyFilteredState() {
    // Matches exist, but not in current filter range
    return Column(
      children: [
        // Keep the time range filter at the top for easy access
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Row(children: [const TimeRangeFilter(), const Spacer()]),
        ),
        // Clean empty state below
        Expanded(child: EmptyStateExamples.homeFiltered(context)),
      ],
    );
  }

  Widget _buildContent(List filteredMatches) {
    final matches = filteredMatches;

    final wins = matches
        .where((m) => getMatchOutcome(m) == MatchOutcome.win)
        .length;
    final losses = matches
        .where((m) => getMatchOutcome(m) == MatchOutcome.loss)
        .length;
    final draws = matches
        .where((m) => getMatchOutcome(m) == MatchOutcome.draw)
        .length;

    final lastMatch = matches.isNotEmpty ? matches.first : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time range filter
          Row(
            children: [
              const TimeRangeFilter(),
              const Spacer(),
              Text(
                AppLocalizations.of(context)!.matchesPlural(matches.length),
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          PerformanceBlockWidget(
            totalMatches: matches.length,
            wins: wins,
            losses: losses,
            draws: draws,
            matches: matches,
            getPerformanceMessage: _getPerformanceMessage,
            getRecentOutcomes: _getRecentOutcomes,
          ),
          if (lastMatch != null) ...[
            const SizedBox(height: 20),
            LastMatchBlockWidget(
              match: lastMatch,
              buildSetScores: _buildSetScores,
            ),
            // Only show details if at least one of duration or location is present
            if (lastMatch.duration != null ||
                (lastMatch.location != null &&
                    lastMatch.location!.isNotEmpty)) ...[
              const SizedBox(height: 20),
              Row(
                children: [
                  if (lastMatch.duration != null) ...[
                    Expanded(
                      child: DurationCardWidget(duration: lastMatch.duration),
                    ),
                    if (lastMatch.location != null &&
                        lastMatch.location!.isNotEmpty)
                      const SizedBox(width: 16),
                  ],
                  if (lastMatch.location != null &&
                      lastMatch.location!.isNotEmpty)
                    Expanded(
                      child: LocationCardWidget(location: lastMatch.location),
                    ),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }
}
