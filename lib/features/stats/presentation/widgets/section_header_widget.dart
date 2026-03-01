import 'package:flutter/material.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}
