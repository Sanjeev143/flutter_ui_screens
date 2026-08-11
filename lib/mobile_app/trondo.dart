import 'dart:math' as math;
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() {
  runApp(const TornadoApp());
}

class TornadoApp extends StatelessWidget {
  const TornadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tornado Effect',
      theme: ThemeData.dark(),
      home: const TornadoScreen(),
    );
  }
}

class TornadoScreen extends StatefulWidget {
  const TornadoScreen({super.key});

  @override
  State<TornadoScreen> createState() => _TornadoScreenState();
}

class _TornadoScreenState extends State<TornadoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<TornadoParticle> _particles;
  final int _particleCount = 180;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Initialize particles with randomized vortex properties
    _particles = List.generate(
      _particleCount,
          (index) => TornadoParticle.random(index, _particleCount),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.heightOf(context) - 30,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: TornadoPainter(
                    animationValue: _controller.value,
                    particles: _particles,
                  ),
                );
              },
            ),
          ),
          Text("Amazevalley")
        ],
      )
    );
  }
}

// ==========================================
// TORNADO PAINTER (CUSTOM PAINTER)
// ==========================================
class TornadoPainter extends CustomPainter {
  final double animationValue;
  final List<TornadoParticle> particles;

  TornadoPainter({
    required this.animationValue,
    required this.particles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double bottomY = size.height * 0.82; // Funnel tip
    final double topY = size.height * 0.18; // Funnel opening

    // 1. Draw Ground Ambient Shadow/Glow
    final Paint groundGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.cyanAccent.withOpacity(0.3),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(center: Offset(centerX, bottomY), radius: 60),
      );
    canvas.drawCircle(Offset(centerX, bottomY), 60, groundGlow);

    // 2. Render Swirling Tornado Particles
    for (var particle in particles) {
      // Calculate continuous progress upward (0.0 at bottom to 1.0 at top)
      double progress = (particle.baseHeight + animationValue) % 1.0;

      // Vertical Y coordinate
      double currentY = bottomY - (progress * (bottomY - topY));

      // Cone Radius expands as height increases (Inverted Pyramid)
      double coneRadius = math.pow(progress, 1.3) * (size.width * 0.38);

      // Swirling Angle calculation (Rotates faster near the narrow bottom)
      double spinSpeed = (1.5 - progress) * 12.0;
      double angle = particle.initialAngle + (animationValue * spinSpeed * math.pi * 2);

      // 3D Offset math (X and Z depth)
      double xOffset = math.cos(angle) * coneRadius;
      double zDepth = math.sin(angle); // Range -1.0 to 1.0 for depth illusion

      // Simulated X wobble (natural sway)
      double sway = math.sin(animationValue * math.pi * 2 + progress * 3) * (progress * 25);
      double currentX = centerX + xOffset + sway;

      // Depth perception adjustments (scale and opacity)
      double depthScale = ui.lerpDouble(0.4, 1.2, (zDepth + 1.0) / 2.0)!;
      double opacity = ui.lerpDouble(0.2, 0.85, (zDepth + 1.0) / 2.0)!;

      // Particle Color Gradient
      Color particleColor = Color.lerp(
        Colors.cyanAccent,
        Colors.purpleAccent,
        progress,
      )!.withOpacity(opacity * (1.0 - (progress * 0.2)));

      final Paint particlePaint = Paint()
        ..color = particleColor
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          (1.2 - depthScale) * 3.0, // Blur particles that are "further back"
        );

      // Draw particle
      canvas.drawCircle(
        Offset(currentX, currentY),
        particle.size * depthScale,
        particlePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant TornadoPainter oldDelegate) {
    return true; // Redraw every frame for smooth 60/120 FPS animation
  }
}

// ==========================================
// TORNADO PARTICLE MODEL
// ==========================================
class TornadoParticle {
  final double baseHeight; // Initial vertical position along the funnel (0.0 to 1.0)
  final double initialAngle; // Radial offset
  final double size; // Base radius of the particle dot

  TornadoParticle({
    required this.baseHeight,
    required this.initialAngle,
    required this.size,
  });

  factory TornadoParticle.random(int index, int total) {
    final math.Random random = math.Random(index);
    return TornadoParticle(
      baseHeight: index / total, // Evenly distributes particles along the vortex
      initialAngle: random.nextDouble() * math.pi * 2,
      size: random.nextDouble() * 3.5 + 2.0,
    );
  }
}