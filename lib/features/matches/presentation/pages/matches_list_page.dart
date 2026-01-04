import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padel_tracker/features/matches/presentation/pages/add_match_page.dart';
import 'package:padel_tracker/features/matches/presentation/pages/match_detail_page.dart';
import 'package:padel_tracker/features/matches/state/matches_provider.dart';
import 'package:padel_tracker/features/shared/state/filtered_matches_provider.dart';
import 'package:padel_tracker/features/shared/widgets/time_range_filter.dart';
import 'package:padel_tracker/features/shared/widgets/empty_state_examples.dart';
import 'package:padel_tracker/features/matches/presentation/widgets/match_card.dart';
import 'package:padel_tracker/domain/models/match.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';

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
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.myMatchesTitle,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1D1D1F),
          ),
        ),
        backgroundColor: const Color(0xFFF8F8F8),
        elevation: 0,
        centerTitle: false,
        actions: matchesState.matches.isNotEmpty
            ? [
                TextButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddMatchPage(),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.newMatch,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF007AFF),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ]
            : null,
      ),
      body: _buildBody(matchesState, filteredMatches),
    );
  }

  Widget _buildBody(matchesState, List<Match> filteredMatches) {
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
                )!.matchesCount(filteredMatches.length),
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF1D1D1F).withValues(alpha: 0.6),
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
                      color: const Color(0xFFFF3B30),
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
