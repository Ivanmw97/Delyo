import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delyo/presentation/theme/app_colors.dart';
import 'package:delyo/features/matches/presentation/pages/add_match_page.dart';
import 'package:delyo/features/matches/presentation/pages/match_detail_page.dart';
import 'package:delyo/features/matches/state/matches_provider.dart';
import 'package:delyo/features/matches/state/matches_state.dart';
import 'package:delyo/features/shared/state/filtered_matches_provider.dart';
import 'package:delyo/features/shared/widgets/time_range_filter.dart';
import 'package:delyo/features/shared/widgets/empty_state_examples.dart';
import 'package:delyo/features/matches/presentation/widgets/match_card.dart';
import 'package:delyo/domain/models/match.dart';
import 'package:delyo/l10n/app_localizations.dart';

class MatchesListPage extends ConsumerStatefulWidget {
  const MatchesListPage({super.key});

  @override
  ConsumerState<MatchesListPage> createState() => _MatchesListPageState();
}

class _MatchesListPageState extends ConsumerState<MatchesListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(matchesProvider.notifier).loadMatches());
  }

  @override
  Widget build(BuildContext context) {
    final matchesState = ref.watch(matchesProvider);
    final filteredMatches = ref.watch(filteredMatchesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.myMatchesTitle,
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        centerTitle: false,
      ),
      body: _buildBody(matchesState, filteredMatches),
      floatingActionButton: matchesState.matches.isNotEmpty
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddMatchPage()),
                );
              },
              backgroundColor: AppColors.accent,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildBody(MatchesState matchesState, List<Match> filteredMatches) {
    if (matchesState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (matchesState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(
                context,
              )!.error(matchesState.error.toString()),
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(matchesProvider.notifier).loadMatches();
              },
              child: Text(AppLocalizations.of(context)!.retry),
            ),
          ],
        ),
      );
    }

    // Implement consistent empty state logic
    if (matchesState.matches.isEmpty) {
      // First-time user (no matches at all)
      return EmptyStateExamples.myMatchesFirstTime(
        context,
        onAddMatch: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMatchPage()),
          );
        },
      );
    } else if (filteredMatches.isEmpty) {
      // Matches exist, but not in current filter range
      return _buildFilteredEmptyState();
    }

    return Column(
      children: [
        // Time range filter
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Row(
            children: [
              const TimeRangeFilter(),
              const Spacer(),
              Text(
                AppLocalizations.of(
                  context,
                )!.matchesPlural(filteredMatches.length),
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),

        // Matches list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            itemCount: filteredMatches.length,
            itemBuilder: (context, index) {
              final match = filteredMatches[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Dismissible(
                  key: Key(match.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    decoration: BoxDecoration(
                      color: AppColors.loss,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    return await _handleDismiss(context, match);
                  },
                  child: MatchCard(
                    match: match,
                    onTap: () => _navigateToMatchDetail(context, match),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilteredEmptyState() {
    // Matches exist, but not in current filter range
    return Column(
      children: [
        // Keep the time range filter at the top for easy access
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Row(children: [const TimeRangeFilter(), const Spacer()]),
        ),
        // Clean empty state below
        Expanded(child: EmptyStateExamples.myMatchesFiltered(context)),
      ],
    );
  }

  void _navigateToMatchDetail(BuildContext context, Match match) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MatchDetailPage(match: match)),
    );
  }

  Future<bool> _handleDismiss(BuildContext context, Match match) async {
    ref.read(matchesProvider.notifier).deleteMatch(match.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.matchDeleted),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: AppLocalizations.of(context)!.undo,
          onPressed: () {
            ref.read(matchesProvider.notifier).addMatch(match);
          },
        ),
      ),
    );

    return true;
  }
}
