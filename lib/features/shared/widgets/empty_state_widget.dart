import 'package:flutter/material.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';

/// Empty state widget for when no matches are found
///
/// Displays a user-friendly message with optional call-to-action button
/// when filtered match results are empty.
class EmptyStateWidget extends StatelessWidget {
  final VoidCallback? onAddMatch;

  const EmptyStateWidget({super.key, this.onAddMatch});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF007AFF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                Icons.sports_tennis,
                size: 40,
                color: Color(0xFF007AFF),
              ),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              AppLocalizations.of(context)!.noMatchesThisMonth,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1D1D1F),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // Subtitle
            Text(
              AppLocalizations.of(context)!.noMatchesThisMonthSubtitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF1D1D1F).withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Optional CTA button
            if (onAddMatch != null)
              ElevatedButton.icon(
                onPressed: onAddMatch,
                icon: const Icon(Icons.add, size: 18, color: Colors.white),
                label: Text(
                  AppLocalizations.of(context)!.addMatch,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007AFF),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
