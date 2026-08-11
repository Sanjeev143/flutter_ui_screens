import 'dart:math';

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {

  final double animation;
  final double amplitude;

  WavePainter({
    required this.animation,
    required this.amplitude,
  });

  @override
  void paint(Canvas canvas, Size size) {

    final centerY = size.height / 2;

    drawWave(
      canvas,
      size,
      centerY,
      Colors.deepPurpleAccent,
      0,
      22,
    );

    drawWave(
      canvas,
      size,
      centerY,
      Colors.purpleAccent,
      .7,
      28,
    );

    drawWave(
      canvas,
      size,
      centerY,
      Colors.pinkAccent,
      1.4,
      32,
    );

    drawWave(
      canvas,
      size,
      centerY,
      Colors.orangeAccent,
      2.0,
      18,
    );
  }

  void drawWave(
      Canvas canvas,
      Size size,
      double centerY,
      Color color,
      double phase,
      double height,
      ) {

    final paint = Paint()
      ..color = color.withOpacity(.8)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    for (double x = 0; x <= size.width; x++) {

      double y =
          centerY +
              sin(
                (x / size.width * 4 * pi) +
                    animation * 2 * pi +
                    phase,
              ) *
                  height *
                  amplitude *
                  3;

      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // for (int i = 0; i < 140; i++) {
    //   final x = i * barWidth;
    //
    //   final noise =
    //       sin(i * 0.25 + animation * 6) *
    //           cos(i * 0.12 + animation * 3);
    //
    //   final h = lerpDouble(
    //       8,
    //       120 * amplitude,
    //       (noise + 1) / 2)!;
    //
    //   canvas.drawRRect(
    //     RRect.fromRectAndRadius(
    //       Rect.fromCenter(
    //         center: Offset(x, size.height / 2),
    //         width: 6,
    //         height: h,
    //       ),
    //       const Radius.circular(20),
    //     ),
    //     paint,
    //   );
    // }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) => true;
}