import 'package:flutter/material.dart';
import 'package:delyo/presentation/theme/app_colors.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Widget? actionWidget;
  final IconData? icon;

  const SectionCard({
    super.key,
    required this.title,
    required this.children,
    this.actionWidget,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon!, size: 16, color: AppColors.accent),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.4),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              if (actionWidget != null) actionWidget!,
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
