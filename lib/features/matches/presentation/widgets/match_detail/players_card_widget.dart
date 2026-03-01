import 'package:flutter/material.dart';
import 'package:delyo/presentation/theme/app_colors.dart';
import 'package:delyo/domain/models/match.dart';
import 'package:delyo/l10n/app_localizations.dart';

class PlayersCardWidget extends StatelessWidget {
  final Match match;

  const PlayersCardWidget({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
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
          // Your Team Section
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Your Team header with result chip
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.yourTeam.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accent,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Spacer(),
                        _buildResultChip(_getUserTeamWon(), context),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // User player with avatar
                    Row(
                      children: [
                        _buildAvatar(
                          context,
                          _getUserInitial(context),
                          true,
                        ), // User avatar in blue
                        const SizedBox(width: 12),
                        Text(
                          AppLocalizations.of(context)!.you,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Partner player with avatar
                    Row(
                      children: [
                        _buildAvatar(
                          context,
                          _getInitials(match.partner.name),
                          false,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            match.partner.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // VS Divider
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.08),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'VS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.4),
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.08),
                  ),
                ),
              ],
            ),
          ),

          // Opponent Team
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.opponentTeam.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Spacer(),
                  _buildResultChip(!_getUserTeamWon(), context),
                ],
              ),
              const SizedBox(height: 16),

              // Opponent 1
              Row(
                children: [
                  _buildAvatar(
                    context,
                    _getInitials(match.opponent1.name),
                    false,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      match.opponent1.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Opponent 2
              Row(
                children: [
                  _buildAvatar(
                    context,
                    _getInitials(match.opponent2.name),
                    false,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      match.opponent2.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, String initials, bool isUserTeam) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isUserTeam
            ? AppColors.accent
            : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isUserTeam
                ? Colors.white
                : Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }

  bool _getUserTeamWon() {
    final userSetsWon = match.result.sets
        .where((set) => set.userTeamGames > set.opponentTeamGames)
        .length;
    final opponentSetsWon = match.result.sets
        .where((set) => set.opponentTeamGames > set.userTeamGames)
        .length;
    return userSetsWon > opponentSetsWon;
  }

  Widget _buildResultChip(bool isWinner, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isWinner ? AppColors.win : AppColors.loss,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isWinner
            ? AppLocalizations.of(context)!.win.toUpperCase()
            : AppLocalizations.of(context)!.loss.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  String _getUserInitial(BuildContext context) {
    final youText = AppLocalizations.of(context)!.you;
    return youText.isNotEmpty ? youText[0].toUpperCase() : 'Y';
  }

  String _getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty) {
      return words[0].substring(0, words[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return 'P';
  }
}
