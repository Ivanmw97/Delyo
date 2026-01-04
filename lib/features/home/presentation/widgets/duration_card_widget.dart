import 'package:flutter/material.dart';
import 'package:padel_tracker/utils/duration_formatter.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';

class DurationCardWidget extends StatelessWidget {
  final Duration? duration;

  const DurationCardWidget({super.key, this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88, // Fixed height to match location card
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.duration,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1D1D1F).withOpacity(0.4),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                DurationFormatter.formatDurationWithFallback(
                  duration,
                  context,
                  AppLocalizations.of(context)!.notSet,
                ),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: duration != null
                      ? const Color(0xFF1D1D1F)
                      : const Color(0xFF1D1D1F).withOpacity(0.4),
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
