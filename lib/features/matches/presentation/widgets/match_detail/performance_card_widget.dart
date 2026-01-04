import 'package:flutter/material.dart';
import 'package:padel_tracker/domain/models/match.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';

class PerformanceCardWidget extends StatelessWidget {
  final Match match;

  const PerformanceCardWidget({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D1D1F).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.performanceRating.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1D1D1F).withOpacity(0.4),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),

          Row(
            children: List.generate(5, (index) {
              final rating = index + 1;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  rating <= (match.performanceRating ?? 0)
                      ? Icons.star
                      : Icons.star_border,
                  color: const Color(0xFFFF9500),
                  size: 28,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
