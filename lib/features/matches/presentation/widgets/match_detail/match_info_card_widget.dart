import 'package:flutter/material.dart';
import 'package:padel_tracker/domain/models/match.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';
import 'package:padel_tracker/utils/duration_formatter.dart';

class MatchInfoCardWidget extends StatelessWidget {
  final Match match;

  const MatchInfoCardWidget({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D1D1F).withOpacity(0.04),
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
            AppLocalizations.of(context)!.matchDetails.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1D1D1F).withOpacity(0.4),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),

          _buildInfoRow(
            Icons.sports_tennis,
            AppLocalizations.of(context)!.playingSide,
            _getPlayingSideName(match.playingSide, context),
          ),
          const SizedBox(height: 16),

          _buildInfoRow(
            Icons.emoji_events,
            AppLocalizations.of(context)!.matchType,
            _getMatchTypeName(match.matchType, context),
            isChip: true,
          ),

          if (match.location?.isNotEmpty == true) ...[
            const SizedBox(height: 16),
            _buildInfoRow(
              Icons.location_on,
              AppLocalizations.of(context)!.location,
              match.location!,
            ),
          ],

          if (match.duration != null) ...[
            const SizedBox(height: 16),
            _buildInfoRow(
              Icons.schedule,
              AppLocalizations.of(context)!.duration,
              DurationFormatter.formatDuration(match.duration!, context) ?? '',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    bool isChip = false,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF8E8E93)),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF1D1D1F).withOpacity(0.6),
                ),
              ),
              isChip
                  ? _buildMatchTypeChip(value)
                  : Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D1D1F),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMatchTypeChip(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1D1F).withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1D1D1F).withOpacity(0.8),
        ),
      ),
    );
  }

  String _getPlayingSideName(playingSide, BuildContext context) {
    switch (playingSide.toString()) {
      case 'PlayingSide.right':
        return AppLocalizations.of(context)!.playingSideRight;
      case 'PlayingSide.left':
        return AppLocalizations.of(context)!.playingSideLeft;
      default:
        return AppLocalizations.of(context)!.playingSideRight;
    }
  }

  String _getMatchTypeName(matchType, BuildContext context) {
    switch (matchType.toString()) {
      case 'MatchType.friendly':
        return AppLocalizations.of(context)!.matchTypeFriendly;
      case 'MatchType.league':
        return AppLocalizations.of(context)!.matchTypeLeague;
      case 'MatchType.tournament':
        return AppLocalizations.of(context)!.matchTypeTournament;
      default:
        return AppLocalizations.of(context)!.matchTypeFriendly;
    }
  }
}
