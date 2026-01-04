import 'package:flutter/material.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';

class SetCard extends StatelessWidget {
  final int index;
  final TextEditingController userGamesController;
  final TextEditingController opponentGamesController;
  final bool canRemove;
  final VoidCallback? onRemove;

  const SetCard({
    super.key,
    required this.index,
    required this.userGamesController,
    required this.opponentGamesController,
    this.canRemove = false,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Set ${index + 1}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1D1D1F).withValues(alpha: 0.6),
                ),
              ),
              if (canRemove && onRemove != null)
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: const Color(0xFF1D1D1F).withValues(alpha: 0.4),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ScoreField(
                  controller: userGamesController,
                  label: AppLocalizations.of(context)!.yourTeam,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ScoreField(
                  controller: opponentGamesController,
                  label: AppLocalizations.of(context)!.opponentTeam,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ScoreField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const ScoreField({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1D1D1F).withValues(alpha: 0.4),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1D1D1F),
            ),
          ),
        ),
      ],
    );
  }
}
