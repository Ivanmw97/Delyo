import 'package:flutter/material.dart';
import 'package:delyo/l10n/app_localizations.dart';
import 'package:delyo/presentation/theme/app_colors.dart';

class AddSetButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddSetButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, size: 16, color: AppColors.accent),
            const SizedBox(width: 4),
            Text(
              AppLocalizations.of(context)!.sets,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
