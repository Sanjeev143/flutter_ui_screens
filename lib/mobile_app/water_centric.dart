import 'dart:math' as math;
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() {
  runApp(const WaterCentricForceApp());
}

class WaterCentricForceApp extends StatelessWidget {
  const WaterCentricForceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Centric Force Simulation - By Amazevalley',
      theme: ThemeData.dark(),
      home: const WaterVortexScreen(),
    );
  }
}

class WaterVortexScreen extends StatefulWidget {
  const WaterVortexScreen({super.key});

  @override
  State<WaterVortexScreen> createState() => _WaterVortexScreenState();
}

class _WaterVortexScreenState extends State<WaterVortexScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<WaterParticle> _particles;
  final int _particleCount = 250;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _particles = List.generate(
      _particleCount,
          (index) => WaterParticle.random(index),
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
      backgroundColor: const Color(0xFF030A16), // Deep ocean dark blue
      body: Stack(
        children: [
          // 1. ANIMATED WATER VORTEX CANVAS
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: WaterCentricPainter(
                  animationValue: _controller.value,
                  particles: _particles,
                ),
              );
            },
          ),

          // 2. GLASSMORPHIC DASHBOARD OVERLAY
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Title Bar
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.cyanAccent.withOpacity(0.3)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.water, color: Colors.cyanAccent),
                            SizedBox(width: 10),
                            Text(
                              'CENTRIPETAL FLUID FLOW \nBy Amazevalley',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom Status Card
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: Colors.cyanAccent.withOpacity(0.2)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Inward Vortex Stream',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Logarithmic spiral velocity vector',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white70),
                                ),
                              ],
                            ),
                            Icon(Icons.waves, color: Colors.cyanAccent, size: 28),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// WATER CENTRIC FORCE PAINTER
// ==========================================
class WaterCentricPainter extends CustomPainter {
  final double animationValue;
  final List<WaterParticle> particles;

  WaterCentricPainter({
    required this.animationValue,
    required this.particles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double maxRadius = math.min(size.width, size.height) * 0.45;

    // 1. Draw Deep Water Central Drain Hole (Vortex Core)
    final Paint coreGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF001220),
          const Color(0xFF003865).withOpacity(0.5),
          Colors.cyanAccent.withOpacity(0.15),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.65, 1.0],
      ).createShader(
        Rect.fromCircle(center: center, radius: maxRadius * 1.2),
      );
    canvas.drawCircle(center, maxRadius * 1.2, coreGlow);

    // 2. Draw Concentric Force Ripple Rings
    final Paint ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    const int rings = 5;
    for (int i = 1; i <= rings; i++) {
      double ringProgress = (animationValue + (i / rings)) % 1.0;
      double currentRadius = (1.0 - ringProgress) * maxRadius;

      ringPaint.color = Colors.cyanAccent.withOpacity(ringProgress * 0.3);
      canvas.drawCircle(center, currentRadius, ringPaint);
    }

    // 3. Render Inward Swirling Water Stream Line Trails
    for (var particle in particles) {
      // Progress of particle traveling from edge towards center
      double travelProgress = (particle.baseProgress + animationValue * 0.8) % 1.0;

      // Radius shrinks towards 0 as it approaches center
      double radius = (1.0 - travelProgress) * maxRadius;

      // Rotational angle accelerates dramatically closer to the center vortex
      double spinMultiplier = math.pow(1.0 - travelProgress, -0.6).toDouble();
      double angle = particle.angleOffset + (animationValue * math.pi * 8 * spinMultiplier);

      // Current 2D position along spiral
      double x = center.dx + math.cos(angle) * radius;
      double y = center.dy + math.sin(angle) * radius;

      // Water tail end position (for liquid trail effect)
      double tailAngle = angle - (0.15 * spinMultiplier);
      double tailRadius = radius + 4;
      double tailX = center.dx + math.cos(tailAngle) * tailRadius;
      double tailY = center.dy + math.sin(tailAngle) * tailRadius;

      // Color shifts from bright cyan at edge to deep glowing blue near center
      Color particleColor = Color.lerp(
        Colors.white,
        Colors.cyanAccent,
        travelProgress,
      )!.withOpacity(ui.lerpDouble(0.1, 0.9, travelProgress)!);

      final Paint trailPaint = Paint()
        ..color = particleColor
        ..strokeWidth = ui.lerpDouble(1.0, 3.5, travelProgress)!
        ..strokeCap = StrokeCap.round;

      // Draw particle stream vector
      canvas.drawLine(Offset(tailX, tailY), Offset(x, y), trailPaint);

      // Draw particle head
      final Paint headPaint = Paint()
        ..color = Colors.white.withOpacity(0.8)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);

      canvas.drawCircle(
        Offset(x, y),
        ui.lerpDouble(0.8, 2.2, travelProgress)!,
        headPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant WaterCentricPainter oldDelegate) {
    return true; // Continuously redraw for 60/120 FPS animation
  }
}

// ==========================================
// WATER PARTICLE MODEL
// ==========================================
class WaterParticle {
  final double baseProgress; // Distance along the vortex pathway
  final double angleOffset; // Initial angle offset around the central vortex

  WaterParticle({
    required this.baseProgress,
    required this.angleOffset,
  });

  factory WaterParticle.random(int index) {
    final math.Random random = math.Random(index);
    return WaterParticle(
      baseProgress: random.nextDouble(),
      angleOffset: random.nextDouble() * math.pi * 2,
    );
  }
}