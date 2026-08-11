import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const CandleApp());
}

class CandleApp extends StatelessWidget {
  const CandleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF0F0F1A), // Dark background for contrast
        body: const Center(
          child: LightingCandle(),
        ),
      ),
    );
  }
}

class LightingCandle extends StatefulWidget {
  const LightingCandle({super.key});

  @override
  State<LightingCandle> createState() => _LightingCandleState();
}

class _LightingCandleState extends State<LightingCandle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Continuous loop for flickering flame animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
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
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomPaint(
            size: const Size(300, 450),
        painter: CandlePainter(animationValue: _controller.value),
        ),
            // Text(
            //   'Amazevalley',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 20,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        );
      },
    );
  }
}

class CandlePainter extends CustomPainter {
  final double animationValue;

  CandlePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double candleBottom = size.height - 30;
    final double candleTop = 220;
    final double candleWidth = 70;

    // Slight dynamic offset calculation for flickering effect
    final double flickerX = math.sin(animationValue * math.pi * 3) * 2.5;
    final double flickerY = math.cos(animationValue * math.pi * 2) * 4;

    // 1. DRAW OUTER GLOW / LIGHT RADIUS
    final Offset flameCenter = Offset(centerX + flickerX, candleTop - 35 + flickerY);
    final Paint glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.orangeAccent.withOpacity(0.35 + (animationValue * 0.1)),
          Colors.amber.withOpacity(0.12),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(
        Rect.fromCircle(center: flameCenter, radius: 140 + (animationValue * 10)),
      );

    canvas.drawCircle(flameCenter, 150, glowPaint);

    // 2. DRAW CANDLE BODY
    final Rect candleRect = Rect.fromLTRB(
      centerX - candleWidth / 2,
      candleTop,
      centerX + candleWidth / 2,
      candleBottom,
    );

    final Paint candlePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFFE8D5C4),
          Color(0xFFFFF8F0),
          Color(0xFFD4C0B0),
        ],
        stops: [0.0, 0.4, 1.0],
      ).createShader(candleRect);

    // Rounded Candle Body
    final RRect rCandle = RRect.fromRectAndCorners(
      candleRect,
      bottomLeft: const Radius.circular(10),
      bottomRight: const Radius.circular(10),
    );
    canvas.drawRRect(rCandle, candlePaint);

    // Candle Elliptical Top (Perspective Rim)
    final Paint topEllipsePaint = Paint()..color = const Color(0xFFFAF0E6);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX, candleTop),
        width: candleWidth,
        height: 18,
      ),
      topEllipsePaint,
    );

    // Wax Melt Drop Effect
    final Paint waxDropPaint = Paint()..color = const Color(0xFFFAF0E6);
    final Path waxPath = Path()
      ..moveTo(centerX - 20, candleTop)
      ..cubicTo(centerX - 25, candleTop + 25, centerX - 10, candleTop + 35, centerX - 15, candleTop + 45)
      ..cubicTo(centerX - 20, candleTop + 55, centerX - 5, candleTop + 40, centerX - 5, candleTop);
    canvas.drawPath(waxPath, waxDropPaint);

    // 3. DRAW WICK
    final Paint wickPaint = Paint()
      ..color = const Color(0xFF2C221E)
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final Path wickPath = Path()
      ..moveTo(centerX, candleTop - 2)
      ..quadraticBezierTo(centerX + 2, candleTop - 12, centerX + flickerX * 0.5, candleTop - 22);
    canvas.drawPath(wickPath, wickPaint);

    // 4. DRAW FLAME (Multi-layered Paths)
    // Outer Flame (Orange Red)
    final Path outerFlame = Path()
      ..moveTo(centerX - 16, candleTop - 20)
      ..quadraticBezierTo(
        centerX - 22 + flickerX,
        candleTop - 50 + flickerY,
        centerX + flickerX,
        candleTop - 85 + flickerY,
      )
      ..quadraticBezierTo(
        centerX + 22 + flickerX,
        candleTop - 50 + flickerY,
        centerX + 16,
        candleTop - 20,
      )
      ..close();

    final Paint outerFlamePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.deepOrange,
          Colors.orangeAccent,
          Colors.amber.withOpacity(0.8),
        ],
      ).createShader(outerFlame.getBounds());

    canvas.drawPath(outerFlame, outerFlamePaint);

    // Inner Flame (Bright Yellow Core)
    final Path innerFlame = Path()
      ..moveTo(centerX - 9, candleTop - 20)
      ..quadraticBezierTo(
        centerX - 12 + flickerX * 0.7,
        candleTop - 42 + flickerY,
        centerX + flickerX * 0.7,
        candleTop - 65 + flickerY,
      )
      ..quadraticBezierTo(
        centerX + 12 + flickerX * 0.7,
        candleTop - 42 + flickerY,
        centerX + 9,
        candleTop - 20,
      )
      ..close();

    final Paint innerFlamePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.amber,
          Colors.yellowAccent,
          Colors.white,
        ],
      ).createShader(innerFlame.getBounds());

    canvas.drawPath(innerFlame, innerFlamePaint);

    // Blue Base Glow of Flame
    final Paint blueBasePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.blueAccent.withOpacity(0.8),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(center: Offset(centerX, candleTop - 20), radius: 12),
      );

    canvas.drawCircle(Offset(centerX, candleTop - 20), 10, blueBasePaint);
  }

  @override
  bool shouldRepaint(covariant CandlePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}