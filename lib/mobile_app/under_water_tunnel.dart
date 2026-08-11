import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const UnderWaterTunnelApp());
}

class UnderWaterTunnelApp extends StatelessWidget {
  const UnderWaterTunnelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black, // Background color of the room outside the tunnel
        body: const Center(
          child: UnderWaterViewShell(),
        ),
      ),
    );
  }
}

class UnderWaterViewShell extends StatefulWidget {
  const UnderWaterViewShell({super.key});

  @override
  State<UnderWaterViewShell> createState() => _UnderWaterViewShellState();
}

class _UnderWaterViewShellState extends State<UnderWaterViewShell>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<BubbleParticle> _bubbles;
  final int _bubbleCount = 50;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Controls light flicker speed
    )..repeat();

    _bubbles = List.generate(_bubbleCount, (_) => BubbleParticle());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // Update bubbles position based on time
            for (var bubble in _bubbles) {
              bubble.update(size);
            }

            return CustomPaint(
              size: size,
              painter: TunnelPainter(
                animationValue: _controller.value,
                bubbles: _bubbles,
              ),
            );
          },
        );
      },
    );
  }
}

class TunnelPainter extends CustomPainter {
  final double animationValue;
  final List<BubbleParticle> bubbles;

  TunnelPainter({required this.animationValue, required this.bubbles});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final centerOffset = Offset(centerX, centerY);

    // 1. Draw Outer Sea (Background)
    final Paint seaPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF003D7A), // Lighter center glow
          const Color(0xFF001F40), // Dark deep blue
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: centerOffset, radius: size.width));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), seaPaint);

    // 2. Draw Tunnel Structure (Dark Glass/Metal Frames)
    final double vanishingPointRadius = size.width * 0.1; // "End" of the tunnel
    final double tunnelEntranceRadius = size.width * 0.9; // Entrance

    final Paint structurePaint = Paint()
      ..color = const Color(0xFF101820)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const int ringsCount = 10;
    for (int i = 0; i <= ringsCount; i++) {
      // Perspective rings (closer rings are larger and further apart)
      double t = i / ringsCount;
      double radius =
      ui.lerpDouble(vanishingPointRadius, tunnelEntranceRadius, t * t)!;

      structurePaint.strokeWidth = ui.lerpDouble(1, 10, t)!;
      structurePaint.color = Colors.black.withOpacity(ui.lerpDouble(0.2, 0.8, t)!);

      canvas.drawCircle(centerOffset, radius, structurePaint);
    }

    // 3. Perspective lines (Frames)
    final Paint linePaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..strokeWidth = 3;

    const int segmentCount = 16;
    for (int i = 0; i < segmentCount; i++) {
      double angle = (i * 2 * math.pi) / segmentCount;

      Offset start = Offset(
        centerX + vanishingPointRadius * math.cos(angle),
        centerY + vanishingPointRadius * math.sin(angle),
      );

      Offset end = Offset(
        centerX + tunnelEntranceRadius * math.cos(angle),
        centerY + tunnelEntranceRadius * math.sin(angle),
      );

      canvas.drawLine(start, end, linePaint);
    }

    // 4. Draw Ceilling Light Reflections (Caustics Effect)
    _paintCaustics(canvas, size, centerOffset);

    // 5. Draw Bubbles
    _paintBubbles(canvas);
  }

  void _paintCaustics(Canvas canvas, Size size, Offset center) {
    final double innerRadius = size.width * 0.3;
    final double outerRadius = size.width * 1.5;

    // A shifting arc segment on the ceiling to simulate flickering light
    final double startAngle = -math.pi / 1.2 + math.sin(animationValue * 2 * math.pi) * 0.1;
    const double sweepAngle = math.pi / 1.5;

    final Paint causticPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0x6699FFFF), // Soft cyan
          Colors.transparent,
        ],
        stops: const [0.4, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: outerRadius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height * 0.4
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20); // Soften light

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: innerRadius + (outerRadius - innerRadius)/2),
      startAngle,
      sweepAngle,
      false,
      causticPaint,
    );
  }

  void _paintBubbles(Canvas canvas) {
    final Paint bubblePaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    for (var bubble in bubbles) {
      canvas.drawCircle(Offset(bubble.x, bubble.y), bubble.radius, bubblePaint);
    }
  }

  @override
  bool shouldRepaint(covariant TunnelPainter oldDelegate) {
    return true; // Continuously repaint for animations
  }
}

class BubbleParticle {
  double x = 0;
  double y = 0;
  double radius = 0;
  double speedY = 0;
  final math.Random _random = math.Random();

  BubbleParticle() {
    reset(true);
  }

  void reset(bool fullReset) {
    // Randomize initial position and speed
    radius = _random.nextDouble() * 3 + 1;
    speedY = _random.nextDouble() * 1.5 + 0.5;

    if (fullReset) {
      x = _random.nextDouble() * 500; // Size isn't known yet, use large number
      y = _random.nextDouble() * 500;
    } else {
      // Re-spawn from bottom
      y = 600 + radius; // Re-spawn below screen
    }
  }

  void update(Size size) {
    // If resetting for the first time, constrain x to size
    if (x > size.width) x = _random.nextDouble() * size.width;
    if (y > size.height && y < 1000) y = _random.nextDouble() * size.height;


    // Move upwards
    y -= speedY;

    // Reset bubble if it goes off top of screen
    if (y < -radius) {
      reset(false);
      x = _random.nextDouble() * size.width;
      y = size.height + radius;
    }
  }
}