import 'package:flutter/material.dart';
import 'package:padel_tracker/domain/enums/match_type.dart';

class MatchTypesBreakdownWidget extends StatelessWidget {
  final List matches;

  const MatchTypesBreakdownWidget({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    final friendly = matches
        .where((m) => m.matchType == MatchType.friendly)
        .length;
    final league = matches.where((m) => m.matchType == MatchType.league).length;
    final tournament = matches
        .where((m) => m.matchType == MatchType.tournament)
        .length;
    final total = matches.length;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D1D1F).withValues(alpha: 0.04),
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
            'Match Types',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1D1D1F).withValues(alpha: 0.4),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),

          _buildMatchTypeBar(
            'Friendly',
            friendly,
            total,
            const Color(0xFF007AFF),
          ),
          const SizedBox(height: 12),
          _buildMatchTypeBar('League', league, total, const Color(0xFFFF9500)),
          const SizedBox(height: 12),
          _buildMatchTypeBar(
            'Tournament',
            tournament,
            total,
            const Color(0xFF5856D6),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchTypeBar(String label, int count, int total, Color color) {
    final percentage = total > 0 ? count / total : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1D1D1F),
              ),
            ),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1D1D1F).withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
