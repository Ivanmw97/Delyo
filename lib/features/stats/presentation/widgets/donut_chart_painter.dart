import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:delyo/presentation/theme/app_colors.dart';

class DonutChartPainter extends CustomPainter {
  final int wins;
  final int losses;
  final int draws;
  final int total;

  DonutChartPainter({
    required this.wins,
    required this.losses,
    required this.draws,
    required this.total,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (total == 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final strokeWidth = 24.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startAngle = -math.pi / 2;

    // Draw wins
    if (wins > 0) {
      final sweepAngle = (wins / total) * 2 * math.pi;
      paint.color = AppColors.win;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }

    // Draw losses
    if (losses > 0) {
      final sweepAngle = (losses / total) * 2 * math.pi;
      paint.color = AppColors.loss;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }

    // Draw draws
    if (draws > 0) {
      final sweepAngle = (draws / total) * 2 * math.pi;
      paint.color = AppColors.draw;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
