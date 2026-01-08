import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delyo/features/matches/state/matches_provider.dart';
import 'package:delyo/features/shared/state/filtered_matches_provider.dart';
import 'package:delyo/features/shared/widgets/time_range_filter.dart';
import 'package:delyo/features/stats/presentation/widgets/results_distribution_widget.dart';
import 'package:delyo/features/stats/presentation/widgets/match_types_breakdown_widget.dart';
import 'package:delyo/features/stats/presentation/widgets/performance_insights_widget.dart';
import 'package:delyo/features/shared/widgets/empty_state_examples.dart';
import 'package:delyo/features/matches/presentation/pages/add_match_page.dart';
import 'package:delyo/features/stats/presentation/widgets/section_header_widget.dart';
import 'package:delyo/l10n/app_localizations.dart';

class StatsPage extends ConsumerWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesState = ref.watch(matchesProvider);
    final filteredMatches = ref.watch(filteredMatchesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.statsTitle,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1D1D1F),
          ),
        ),
        backgroundColor: const Color(0xFFF8F8F8),
        elevation: 0,
        centerTitle: false,
      ),
      body: matchesState.matches.isEmpty
          ? _buildFirstTimeEmptyState(context)
          : filteredMatches.isEmpty
          ? _buildFilteredEmptyState(context)
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Time range filter
                  Row(
                    children: [
                      const TimeRangeFilter(),
                      const Spacer(),
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.matchesPlural(filteredMatches.length),
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF1D1D1F).withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Results Overview Section
                  SectionHeaderWidget(
                    title: AppLocalizations.of(context)!.yourMatchResultsSoFar,
                    subtitle: AppLocalizations.of(
                      context,
                    )!.seeHowPerformingOverall,
                  ),
                  const SizedBox(height: 16),
                  ResultsDistributionWidget(matches: filteredMatches),
                  const SizedBox(height: 32),

                  // Match Types Section
                  SectionHeaderWidget(
                    title: _getMatchTypesNarrative(filteredMatches, context),
                    subtitle: AppLocalizations.of(
                      context,
                    )!.typesOfMatchesPlayMost,
                  ),
                  const SizedBox(height: 16),
                  MatchTypesBreakdownWidget(matches: filteredMatches),
                  const SizedBox(height: 32),

                  // Performance Section
                  SectionHeaderWidget(
                    title: AppLocalizations.of(context)!.howPerformingRecently,
                    subtitle: AppLocalizations.of(
                      context,
                    )!.consistencyCurrentForm,
                  ),
                  const SizedBox(height: 16),
                  PerformanceInsightsWidget(matches: filteredMatches),
                ],
              ),
            ),
    );
  }

  Widget _buildFirstTimeEmptyState(BuildContext context) {
    // First-time user (no matches at all)
    return EmptyStateExamples.statsFirstTime(
      context,
      onAddMatch: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddMatchPage()),
        );
      },
    );
  }

  Widget _buildFilteredEmptyState(BuildContext context) {
    // Matches exist, but not in current filter range
    return Column(
      children: [
        // Keep the time range filter at the top for easy access
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Row(children: [const TimeRangeFilter(), const Spacer()]),
        ),
        // Clean empty state below
        Expanded(child: EmptyStateExamples.statsFiltered(context)),
      ],
    );
  }

  String _getMatchTypesNarrative(List matches, BuildContext context) {
    if (matches.isEmpty) return AppLocalizations.of(context)!.yourMatchTypes;

    // Count match types
    final friendly = matches
        .where((m) => m.matchType.toString().contains('friendly'))
        .length;
    final league = matches
        .where((m) => m.matchType.toString().contains('league'))
        .length;
    final tournament = matches
        .where((m) => m.matchType.toString().contains('tournament'))
        .length;

    // Find the most common type
    if (friendly >= league && friendly >= tournament) {
      return AppLocalizations.of(context)!.youMostlyPlayFriendly;
    } else if (league >= tournament) {
      return AppLocalizations.of(context)!.youFocusOnLeague;
    } else {
      return AppLocalizations.of(context)!.youCompeteInTournaments;
    }
  }
}
