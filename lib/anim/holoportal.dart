import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const HoloDropApp());

class HoloDropApp extends StatelessWidget {
  const HoloDropApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HoloDropScreen(),
    );
  }
}

class HoloDropScreen extends StatefulWidget {
  const HoloDropScreen({super.key});
  @override
  State<HoloDropScreen> createState() => _HoloDropScreenState();
}

class _HoloDropScreenState extends State<HoloDropScreen>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  late AnimationController _orbController;
  late AnimationController _tentacleController;

  @override
  void initState() {
    super.initState();
    _glowController =
    AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
    _orbController =
    AnimationController(vsync: this, duration: const Duration(seconds: 6))
      ..repeat();
    _tentacleController =
    AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    _orbController.dispose();
    _tentacleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030510),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _glowController,
                  builder: (_, __) => CustomPaint(
                    painter: BackgroundPainter(_glowController.value),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: constraints.maxWidth * 0.9,
                  height: constraints.maxWidth * 1.1, // taller for drop
                  child: AnimatedBuilder(
                    animation: Listenable.merge([
                      _glowController,
                      _orbController,
                      _tentacleController
                    ]),
                    builder: (_, __) => CustomPaint(
                      painter: DropPortalPainter(
                        glow: _glowController.value,
                        orb: _orbController.value,
                        tentacle: _tentacleController.value,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: constraints.maxHeight * 0.15,
                left: constraints.maxWidth * 0.25,
                child: Transform.rotate(angle: -0.2, child: _PhoneWidget()),
              ),
              Positioned(
                bottom: constraints.maxHeight * 0.08,
                left: constraints.maxWidth * 0.18,
                child: _HandWidget(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DropPortalPainter extends CustomPainter {
  final double glow;
  final double orb;
  final double tentacle;
  final Random random = Random();

  DropPortalPainter({required this.glow, required this.orb, required this.tentacle});

  Path _waterDropPath(Offset center, double size) {
    // Creates a teardrop pointing down
    Path path = Path();
    path.moveTo(center.dx, center.dy + size); // bottom point
    path.quadraticBezierTo(
        center.dx - size, center.dy, center.dx, center.dy - size * 0.6); // left curve
    path.quadraticBezierTo(
        center.dx + size, center.dy, center.dx, center.dy + size); // right curve
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 - 20);
    final dropSize = size.width * 0.35;

    // 1. Outer glow for drop
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.cyan.withOpacity(0.3 + glow * 0.3),
          Colors.transparent
        ],
      ).createShader(Rect.fromCircle(center: center, radius: dropSize * 1.8));
    canvas.drawPath(_waterDropPath(center, dropSize * 1.2), glowPaint);

    // 2. Water drop ring
    final dropPath = _waterDropPath(center, dropSize);
    final ringPaint = Paint()
      ..color = Colors.cyanAccent.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 + glow
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawPath(dropPath, ringPaint);

    // inner ring
    canvas.drawPath(_waterDropPath(center, dropSize * 0.9), ringPaint..strokeWidth = 1);

    // 3. Central "energy crystal" inside drop
    final crystalPath = Path();
    crystalPath.moveTo(center.dx, center.dy - dropSize * 0.3);
    crystalPath.quadraticBezierTo(center.dx - 15, center.dy, center.dx, center.dy + dropSize * 0.3);
    crystalPath.quadraticBezierTo(center.dx + 15, center.dy, center.dx, center.dy - dropSize * 0.3);
    final crystalPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.cyanAccent, Colors.blue.shade700, Colors.purple],
      ).createShader(crystalPath.getBounds());
    canvas.drawPath(crystalPath, crystalPaint);

    // 4. Animated tentacles coming out from drop edges
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 + tentacle * 30) * pi / 180;
      final tentaclePath = Path();
      tentaclePath.moveTo(center.dx, center.dy);
      final endX = center.dx + cos(angle) * dropSize * (0.9 + sin(tentacle * pi + i) * 0.2);
      final endY = center.dy + sin(angle) * dropSize * (0.9 + sin(tentacle * pi + i) * 0.2);
      tentaclePath.quadraticBezierTo(
        center.dx + cos(angle) * dropSize * 0.4,
        center.dy + sin(angle) * dropSize * 0.4 + sin(tentacle * pi * 2 + i) * 10,
        endX,
        endY,
      );
      final tentaclePaint = Paint()
        ..color = Colors.cyanAccent.withOpacity(0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawPath(tentaclePath, tentaclePaint);
    }

    // 5. Floating orbs around the drop
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45 + orb * 360) * pi / 180;
      final orbRadius = dropSize * (0.85 + sin(orb * pi * 2 + i) * 0.1);
      final orbX = center.dx + cos(angle) * orbRadius;
      final orbY = center.dy + sin(angle) * orbRadius * 0.8; // squish Y to follow drop
      final orbPaint = Paint()
        ..color = Colors.blueAccent.withOpacity(0.8)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      canvas.drawCircle(Offset(orbX, orbY), 12 + sin(glow * pi * 2 + i) * 3, orbPaint);
      canvas.drawCircle(Offset(orbX, orbY), 4, Paint()..color = Colors.white.withOpacity(0.9));
    }
  }

  @override
  bool shouldRepaint(covariant DropPortalPainter oldDelegate) => true;
}

class BackgroundPainter extends CustomPainter {
  final double value;
  BackgroundPainter(this.value);
  final Random random = Random();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.cyan.withOpacity(0.02 * value);
    for (int i = 0; i < 50; i++) {
      canvas.drawCircle(
        Offset(size.width * random.nextDouble(), size.height * random.nextDouble()),
        random.nextDouble() * 2,
        paint,
      );
    }
  }
  @override
  bool shouldRepaint(covariant BackgroundPainter oldDelegate) => true;
}

class _PhoneWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 240,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.cyan.withOpacity(0.5), blurRadius: 20, spreadRadius: 5)
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyanAccent, Colors.blue.shade900],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class _HandWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: const Size(100, 120), painter: HandPainter());
  }
}

class HandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFD2A679);
    final path = Path();
    path.moveTo(20, 100);
    path.lineTo(30, 40);
    path.lineTo(50, 20);
    path.quadraticBezierTo(60, 30, 55, 50);
    path.lineTo(70, 10);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}