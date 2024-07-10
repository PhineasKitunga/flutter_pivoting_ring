import 'package:flutter/material.dart';
import 'dart:math' as math;

class PivotingRing extends StatefulWidget {
  @override
  _PivotingRingState createState() => _PivotingRingState();
}

class _PivotingRingState extends State<PivotingRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: Ring3DPainter(_controller.value),
          size: const Size(450, 20),
        );
      },
    );
  }
}

class Ring3DPainter extends CustomPainter {
  final double animationValue;

  Ring3DPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;
    final ringWidth = size.width * 0.1;

    for (int i = 0; i < 360; i++) {
      final angle = i * math.pi / 180;
      final rotationAngle = animationValue * 2 * math.pi;

      // Apply 3D rotation
      final x = radius * math.cos(angle);
      final y = radius * math.sin(angle);
      final z = 0.0;

      final rotatedX =
          x * math.cos(rotationAngle) - z * math.sin(rotationAngle);
      final rotatedZ =
          x * math.sin(rotationAngle) + z * math.cos(rotationAngle);

      // Apply perspective
      final scale = 200 / (200 - rotatedZ);
      final perspectiveX = rotatedX * scale;
      final perspectiveY = y * scale;

      final paint = Paint()
        ..color = _getRingColor(angle)
        ..style = PaintingStyle.stroke
        ..strokeWidth = ringWidth * scale;

      canvas.drawCircle(
        center + Offset(perspectiveX, perspectiveY),
        ringWidth / 2 * scale,
        paint,
      );
    }
  }

  Color _getRingColor(double angle) {
    final hue = (angle / (2 * math.pi) * 360 + 180) % 360;
    return HSLColor.fromAHSL(1.0, hue, 1.0, 0.5).toColor();
  }

  @override
  bool shouldRepaint(covariant Ring3DPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
