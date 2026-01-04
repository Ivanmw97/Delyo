import 'package:flutter/material.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';

class LocationCardWidget extends StatelessWidget {
  final String? location;

  const LocationCardWidget({super.key, this.location});

  @override
  Widget build(BuildContext context) {
    final displayText = location ?? AppLocalizations.of(context)!.notSet;

    return Container(
      height: 88, // Fixed height to match duration card
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
            AppLocalizations.of(context)!.location,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1D1D1F).withValues(alpha: 0.4),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                displayText,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: location != null
                      ? const Color(0xFF1D1D1F)
                      : const Color(0xFF1D1D1F).withValues(alpha: 0.4),
                  letterSpacing: -0.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
