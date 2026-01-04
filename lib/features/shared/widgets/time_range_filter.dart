import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padel_tracker/domain/enums/time_range.dart';
import 'package:padel_tracker/features/shared/state/time_filter_provider.dart';

/// Time range filter widget
///
/// Displays the current time range selection and allows users to change it.
/// This widget can be placed in any view that needs time filtering.
class TimeRangeFilter extends ConsumerWidget {
  const TimeRangeFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRange = ref.watch(timeRangeProvider);

    return PopupMenuButton<TimeRange>(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF007AFF).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF007AFF).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.filter_list, size: 16, color: const Color(0xFF007AFF)),
            const SizedBox(width: 6),
            Text(
              currentRange.displayName(context),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF007AFF),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              size: 18,
              color: const Color(0xFF007AFF),
            ),
          ],
        ),
      ),
      onSelected: (TimeRange range) {
        ref.read(timeRangeProvider.notifier).state = range;
      },
      itemBuilder: (context) => TimeRange.values
          .map(
            (range) => PopupMenuItem(
              value: range,
              child: Row(
                children: [
                  if (range == currentRange)
                    const Icon(Icons.check, size: 16, color: Color(0xFF007AFF))
                  else
                    const SizedBox(width: 16),
                  const SizedBox(width: 8),
                  Text(
                    range.displayName(context),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: range == currentRange
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: range == currentRange
                          ? const Color(0xFF007AFF)
                          : const Color(0xFF1D1D1F),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
