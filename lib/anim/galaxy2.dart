import 'dart:math';
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
      home: Scaffold(
        body: GalaxyView(),
      ),
    );
  }
}

class GalaxyView extends StatefulWidget {
  const GalaxyView({super.key});

  @override
  State<GalaxyView> createState() => _GalaxyViewState();
}

class _GalaxyViewState extends State<GalaxyView>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  final List<Star> _stars = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    // Smooth 60-second rotation for a majestic, slow universe feel
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();

    _generateStars(1000);
  }

  void _generateStars(int count) {
    for (int i = 0; i < count; i++) {
      _stars.add(Star(
        angle: _random.nextDouble() * 2 * pi, // Angle relative to center
        distanceFactor: _random.nextDouble(), // Radius offset (0.0 center to 1.0 edge)
        baseSize: _random.nextDouble() * 2.0 + 0.4,
        twinkleSpeed: _random.nextDouble() * 3 + 1,
        isBright: _random.nextDouble() < 0.08, // Bright core stars
      ));
    }
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
          size: Size.infinite,
          painter: GalaxyPainter(
            stars: _stars,
            progress: _controller.value,
          ),
        );
      },
    );
  }
}

/// Model for stars radiating outward from the central core
class Star {
  final double angle;
  final double distanceFactor;
  final double baseSize;
  final double twinkleSpeed;
  final bool isBright;

  Star({
    required this.angle,
    required this.distanceFactor,
    required this.baseSize,
    required this.twinkleSpeed,
    required this.isBright,
  });
}

class GalaxyPainter extends CustomPainter {
  final List<Star> stars;
  final double progress; // Progress loop from 0.0 to 1.0

  GalaxyPainter({required this.stars, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double maxRadius = sqrt(center.dx * center.dx + center.dy * center.dy);

    // 1. Deep Void Background
    final Rect rect = Offset.zero & size;
    final Paint bgPaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment.center,
        radius: 1.0,
        colors: [
          Color(0xFF1E0A38), // Purple center core
          Color(0xFF090314), // Outer space black
          Color(0xFF010005),
        ],
      ).createShader(rect);

    canvas.drawRect(rect, bgPaint);

    // 2. Bright Galactic Core at Exact Center
    _drawCenterCore(canvas, center, size.width * 0.35);

    // Save state before rotation
    canvas.save();

    // 3. Clockwise Center Rotation
    final double rotationAngle = progress * 2 * pi;
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotationAngle); // Clockwise rotation around center
    canvas.translate(-center.dx, -center.dy);

    // 4. Draw Spiral Nebulae Arms Emanating from Center
    _drawSpiralNebula(canvas, center, maxRadius * 0.7);

    // 5. Draw Center-Based Stars drifting gently outwards
    for (var star in stars) {
      // Outward motion effect: star distance grows with progress, looping smoothly
      double currentDistanceFactor = (star.distanceFactor + progress * 0.2) % 1.0;
      double distance = currentDistanceFactor * maxRadius;

      // Calculate star coordinates based on radial center coordinates
      double starX = center.dx + distance * cos(star.angle);
      double starY = center.dy + distance * sin(star.angle);

      // Stars get slightly larger and brighter as they move closer to viewer
      double scale = 0.3 + (currentDistanceFactor * 1.2);
      double currentSize = star.baseSize * scale;

      // Twinkle calculation
      final double twinkle =
          (sin((progress * 2 * pi * star.twinkleSpeed) + star.angle) + 1) / 2;
      final double alpha = ((0.2 + (twinkle * 0.8)) * currentDistanceFactor).clamp(0.0, 1.0);

      final Paint starPaint = Paint()..color = Colors.white.withOpacity(alpha);

      if (star.isBright && currentDistanceFactor > 0.15) {
        // Glowing aura for central/bright stars
        final Paint glowPaint = Paint()
          ..shader = RadialGradient(
            colors: [
              const Color(0xFF80DEEA).withOpacity(0.8 * alpha),
              const Color(0xFF00B0FF).withOpacity(0.2 * alpha),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(center: Offset(starX, starY), radius: currentSize * 5),
          );

        canvas.drawCircle(Offset(starX, starY), currentSize * 5, glowPaint);

        // Diffraction spikes
        final Paint spikePaint = Paint()
          ..color = Colors.white.withOpacity(0.8 * alpha)
          ..strokeWidth = 1.0;

        double spikeLen = currentSize * 4;
        canvas.drawLine(Offset(starX - spikeLen, starY), Offset(starX + spikeLen, starY), spikePaint);
        canvas.drawLine(Offset(starX, starY - spikeLen), Offset(starX, starY + spikeLen), spikePaint);
      }

      // Draw star dot
      canvas.drawCircle(Offset(starX, starY), currentSize, starPaint);
    }

    canvas.restore();
  }

  /// Draws glowing galaxy core at screen center
  void _drawCenterCore(Canvas canvas, Offset center, double radius) {
    final Paint corePaint = Paint()
      ..blendMode = BlendMode.screen
      ..shader = RadialGradient(
        colors: [
          Colors.white,
          const Color(0xFFE040FB).withOpacity(0.8), // Bright Magenta
          const Color(0xFF00E5FF).withOpacity(0.5), // Glowing Cyan
          const Color(0xFF651FFF).withOpacity(0.2), // Deep Violet
          Colors.transparent,
        ],
        stops: const [0.0, 0.15, 0.4, 0.7, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, corePaint);
  }

  /// Draws spiral nebula clouds rotating around center
  void _drawSpiralNebula(Canvas canvas, Offset center, double maxRadius) {
    List<Color> colors = [
      const Color(0xFFFF4081).withOpacity(0.3), // Pink
      const Color(0xFF7C4DFF).withOpacity(0.25), // Purple
      const Color(0xFF00B0FF).withOpacity(0.2), // Blue
    ];

    for (int i = 0; i < 3; i++) {
      double armAngleOffset = (i * 2 * pi) / 3;

      for (double r = 40; r < maxRadius; r += 50) {
        double theta = armAngleOffset + (r * 0.005);
        double cloudX = center.dx + r * cos(theta);
        double cloudY = center.dy + r * sin(theta);

        final Paint cloudPaint = Paint()
          ..blendMode = BlendMode.screen
          ..shader = RadialGradient(
            colors: [
              colors[i % colors.length],
              Colors.transparent,
            ],
          ).createShader(Rect.fromCircle(
              center: Offset(cloudX, cloudY), radius: r * 0.4));
        canvas.drawCircle(Offset(cloudX, cloudY), r * 0.4, cloudPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant GalaxyPainter oldDelegate) => true;
}