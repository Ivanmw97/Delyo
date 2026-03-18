import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kompkit_core/kompkit_core.dart';
import 'package:delyo/l10n/app_localizations.dart';

class SetCard extends StatelessWidget {
  final int index;
  final TextEditingController userGamesController;
  final TextEditingController opponentGamesController;
  final bool canRemove;
  final VoidCallback? onRemove;
  final VoidCallback? onScoreChanged;

  const SetCard({
    super.key,
    required this.index,
    required this.userGamesController,
    required this.opponentGamesController,
    this.canRemove = false,
    this.onRemove,
    this.onScoreChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
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
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.4),
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
                  onChanged: onScoreChanged,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ScoreField(
                  controller: opponentGamesController,
                  label: AppLocalizations.of(context)!.opponentTeam,
                  onChanged: onScoreChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Restricts score input to a single digit 0–7 (max games in a padel set).
class _ScoreInputFormatter extends TextInputFormatter {
  static const int _minScore = 0;
  static const int _maxScore = 7;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;
    final value = int.tryParse(text);
    if (value == null) return oldValue;
    // Only allow single digit
    if (text.length > 1) return oldValue;
    final clamped = clamp(value.toDouble(), _minScore.toDouble(), _maxScore.toDouble()).toInt();
    if (clamped != value) return oldValue;
    return newValue;
  }
}

class ScoreField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final VoidCallback? onChanged;

  const ScoreField({
    super.key,
    required this.controller,
    required this.label,
    this.onChanged,
  });

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
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.4),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: onChanged != null ? (_) => onChanged!() : null,
            inputFormatters: [_ScoreInputFormatter()],
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
