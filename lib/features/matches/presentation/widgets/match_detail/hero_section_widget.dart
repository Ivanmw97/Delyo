import 'package:flutter/material.dart';
import 'package:delyo/presentation/theme/app_colors.dart';
import 'package:delyo/domain/models/match.dart';
import 'package:delyo/utils/duration_formatter.dart';
import 'package:intl/intl.dart';

class HeroSectionWidget extends StatelessWidget {
  final Match match;

  const HeroSectionWidget({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final setScores = _getSetScoresText();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
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
              color: AppColors.accent,
              letterSpacing: -1.5,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 16),

          // Date
          Text(
            _formatDate(match.dateTime, context),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 16),

          // Meta row with duration and location
          Row(
            children: [
              // Duration with icon
              if (match.duration != null) ...[
                Icon(Icons.access_time, size: 18, color: AppColors.draw),
                const SizedBox(width: 6),
                Text(
                  DurationFormatter.formatDuration(match.duration!, context) ??
                      '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.draw,
                  ),
                ),
              ],

              // Separator and location
              if (match.duration != null &&
                  match.location?.isNotEmpty == true) ...[
                const SizedBox(width: 16),
                Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: AppColors.draw,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
              ],

              // Location with icon
              if (match.location?.isNotEmpty == true) ...[
                Icon(Icons.location_on, size: 18, color: AppColors.draw),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    match.location!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.draw,
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
    return match.result.sets
        .map((set) => '${set.userTeamGames}-${set.opponentTeamGames}')
        .join(', ');
  }
}
