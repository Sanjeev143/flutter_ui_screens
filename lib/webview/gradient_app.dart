import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Animated3DBackground(),
    );
  }
}

class Animated3DBackground extends StatefulWidget {
  const Animated3DBackground({super.key});

  @override
  State<Animated3DBackground> createState() => _Animated3DBackgroundState();
}

class _Animated3DBackgroundState extends State<Animated3DBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: ThreeDBackgroundPainter(
              animation: _controller.value,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class ThreeDBackgroundPainter extends CustomPainter {
  final double animation;

  ThreeDBackgroundPainter({
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    _drawBackground(canvas, size);

    _drawAmbientGlow(
      canvas,
      center,
      size,
    );

    _drawParticles(
      canvas,
      size,
    );

    _drawBackRings(
      canvas,
      center,
      size,
    );

    _drawFloatingOrb(
      canvas,
      center + Offset(-size.width * .22, -size.height * .08),
      size.width * .14,
      animation * math.pi * 2,
      0.0,
    );

    _drawFloatingOrb(
      canvas,
      center + Offset(size.width * .25, size.height * .10),
      size.width * .09,
      -animation * math.pi * 2,
      1.5,
    );

    _drawFloatingOrb(
      canvas,
      center + Offset(size.width * .05, -size.height * .27),
      size.width * .07,
      animation * math.pi * 4,
      2.8,
    );

    _drawMain3DObject(
      canvas,
      center,
      size,
    );

    _drawFrontRings(
      canvas,
      center,
      size,
    );
  }

  void _drawBackground(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF02040D),
          Color(0xFF07132B),
          Color(0xFF0B0620),
          Color(0xFF02040B),
        ],
      ).createShader(rect);

    canvas.drawRect(rect, paint);
  }

  void _drawAmbientGlow(
      Canvas canvas,
      Offset center,
      Size size,
      ) {
    final pulse =
        1.0 + math.sin(animation * math.pi * 2) * 0.09;

    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF38BDF8).withOpacity(.18),
          const Color(0xFF6366F1).withOpacity(.08),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: size.width * .42 * pulse,
        ),
      );

    canvas.drawCircle(
      center,
      size.width * .42 * pulse,
      glowPaint,
    );

    final secondGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFA855F7).withOpacity(.12),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(
            size.width * .18,
            size.height * .25,
          ),
          radius: size.width * .32,
        ),
      );

    canvas.drawCircle(
      Offset(
        size.width * .18,
        size.height * .25,
      ),
      size.width * .32,
      secondGlow,
    );
  }

  void _drawParticles(
      Canvas canvas,
      Size size,
      ) {
    final random = math.Random(42);

    final particlePaint = Paint();

    for (int i = 0; i < 90; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;

      final movement =
          math.sin(animation * math.pi * 2 + i) * 8;

      final radius =
          0.5 + random.nextDouble() * 1.5;

      final opacity =
          .15 + random.nextDouble() * .45;

      particlePaint.color =
          Colors.white.withOpacity(opacity);

      canvas.drawCircle(
        Offset(x, y + movement),
        radius,
        particlePaint,
      );
    }
  }

  void _drawBackRings(
      Canvas canvas,
      Offset center,
      Size size,
      ) {
    canvas.save();

    canvas.translate(center.dx, center.dy);

    final rotation = animation * math.pi * 2;

    canvas.rotate(rotation * .35);

    for (int i = 0; i < 5; i++) {
      final radius = size.width * (.22 + i * .045);

      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: radius * 2,
        height: radius * .55,
      );

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = const Color(0xFF38BDF8)
            .withOpacity(.12 - i * .015);

      canvas.drawOval(rect, paint);
    }

    canvas.restore();
  }

  void _drawFrontRings(
      Canvas canvas,
      Offset center,
      Size size,
      ) {
    canvas.save();

    canvas.translate(center.dx, center.dy);

    final rotation =
        -animation * math.pi * 2;

    canvas.rotate(rotation);

    for (int i = 0; i < 3; i++) {
      final radius =
          size.width * (.30 + i * .055);

      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: radius * 2,
        height: radius * .30,
      );

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = const Color(0xFF818CF8)
            .withOpacity(.16 - i * .03);

      canvas.drawOval(rect, paint);
    }

    canvas.restore();
  }

  void _drawFloatingOrb(
      Canvas canvas,
      Offset position,
      double radius,
      double rotation,
      double phase,
      ) {
    final float =
        math.sin(
          animation * math.pi * 2 + phase,
        ) *
            radius *
            .25;

    final center =
        position + Offset(0, float);

    final glow = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF60A5FA).withOpacity(.25),
          const Color(0xFF6366F1).withOpacity(.10),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: radius * 2,
        ),
      );

    canvas.drawCircle(
      center,
      radius * 2,
      glow,
    );

    final glass = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-.35, -.45),
        colors: [
          Colors.white.withOpacity(.22),
          const Color(0xFF60A5FA).withOpacity(.12),
          const Color(0xFF312E81).withOpacity(.18),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      );

    canvas.drawCircle(
      center,
      radius,
      glass,
    );

    final highlight = Paint()
      ..color = Colors.white.withOpacity(.20);

    canvas.drawCircle(
      center + Offset(
        -radius * .28,
        -radius * .30,
      ),
      radius * .16,
      highlight,
    );

    final outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.white.withOpacity(.16);

    canvas.drawCircle(
      center,
      radius,
      outline,
    );
  }

  void _drawMain3DObject(
      Canvas canvas,
      Offset center,
      Size size,
      ) {
    canvas.save();

    canvas.translate(center.dx, center.dy);

    final rotationY =
        math.sin(animation * math.pi * 2) * .55;

    final rotationZ =
        animation * math.pi * 2;

    final perspective =
    math.cos(rotationY);

    final objectWidth =
        size.width * .45 * perspective.abs();

    final objectHeight =
        size.height * .38;

    canvas.rotate(
      rotationZ * .25,
    );

    // Back glow.
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF38BDF8).withOpacity(.30),
          const Color(0xFF8B5CF6).withOpacity(.12),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCenter(
          center: Offset.zero,
          width: objectWidth * 2.2,
          height: objectHeight * 1.6,
        ),
      );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: objectWidth * 2.0,
        height: objectHeight * 1.5,
      ),
      glowPaint,
    );

    // 3D glass body.
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset.zero,
        width: objectWidth,
        height: objectHeight,
      ),
      Radius.circular(
        size.width * .035,
      ),
    );

    final bodyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(.16),
          const Color(0xFF38BDF8).withOpacity(.07),
          const Color(0xFF8B5CF6).withOpacity(.13),
          Colors.white.withOpacity(.04),
        ],
      ).createShader(
        bodyRect.outerRect,
      );

    canvas.drawRRect(
      bodyRect,
      bodyPaint,
    );

    // Glass border.
    final border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF93C5FD),
          Color(0xFFFFFFFF),
          Color(0xFFA78BFA),
        ],
      ).createShader(
        bodyRect.outerRect,
      );

    canvas.drawRRect(
      bodyRect,
      border,
    );

    // Inner rotating ring.
    canvas.save();

    canvas.rotate(
      -animation * math.pi * 4,
    );

    final ringRect = Rect.fromCenter(
      center: Offset.zero,
      width: objectWidth * 1.15,
      height: objectWidth * .48,
    );

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0xFF67E8F9)
          .withOpacity(.45);

    canvas.drawOval(
      ringRect,
      ringPaint,
    );

    canvas.restore();

    // Second ring with opposite rotation.
    canvas.save();

    canvas.rotate(
      animation * math.pi * 3,
    );

    final ring2 = Rect.fromCenter(
      center: Offset.zero,
      width: objectWidth * 1.35,
      height: objectWidth * .34,
    );

    final ringPaint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = const Color(0xFFA78BFA)
          .withOpacity(.30);

    canvas.drawOval(
      ring2,
      ringPaint2,
    );

    canvas.restore();

    // Highlight.
    final highlight = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(.28),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromLTWH(
          -objectWidth / 2,
          -objectHeight / 2,
          objectWidth,
          objectHeight,
        ),
      );

    canvas.drawRRect(
      bodyRect,
      highlight,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(
      covariant ThreeDBackgroundPainter oldDelegate,
      ) {
    return oldDelegate.animation != animation;
  }
}