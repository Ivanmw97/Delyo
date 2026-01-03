import 'package:flutter/material.dart';
import 'package:padel_tracker/domain/models/match.dart';
import 'package:padel_tracker/utils/duration_formatter.dart';
import 'package:intl/intl.dart';

class HeroSectionWidget extends StatelessWidget {
  final Match match;

  const HeroSectionWidget({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    final setScores = _getSetScoresText();
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F8F8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Match Score - Large and Blue
          Text(
            setScores,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Color(0xFF007AFF), // App's primary blue
              letterSpacing: -1.5,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 16),
          
          // Date
          Text(
            _formatDate(match.dateTime, context),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1D1D1F),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 16),
          
          // Meta row with duration and location
          Row(
            children: [
              // Duration with icon
              if (match.duration != null) ...[
                Icon(
                  Icons.access_time,
                  size: 18,
                  color: const Color(0xFF8E8E93),
                ),
                const SizedBox(width: 6),
                Text(
                  DurationFormatter.formatDuration(match.duration!, context) ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ],
              
              // Separator and location
              if (match.duration != null && match.location?.isNotEmpty == true) ...[
                const SizedBox(width: 16),
                Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8E8E93),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
              ],
              
              // Location with icon
              if (match.location?.isNotEmpty == true) ...[
                Icon(
                  Icons.location_on,
                  size: 18,
                  color: const Color(0xFF8E8E93),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    match.location!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF8E8E93),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date, BuildContext context) {
    final locale = Localizations.localeOf(context);
    final formatter = DateFormat.yMMMMd(locale.toString());
    return formatter.format(date);
  }

  String _getSetScoresText() {
    return match.result.sets.map((set) => '${set.userTeamGames}-${set.opponentTeamGames}').join(', ');
  }

}
